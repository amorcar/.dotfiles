# Edit today's timewarrior entries as a text buffer in $EDITOR.
# Usage: twed [date]
#   twed           → edit today
#   twed yesterday → edit yesterday
#
# Format (one line per entry):
#   HH:MM - HH:MM tag1 tag2
#   HH:MM - now   tag1 tag2   (for active tracking)
#
# You can add, remove, modify, or reorder lines freely.
# On save+quit, all entries for that day are deleted and recreated from the buffer.
function twed --description "Edit timewarrior entries in text buffer"
    set -l target_date (date +%Y-%m-%d)
    set -l display_date "today"

    if test (count $argv) -gt 0
        set target_date (date -j -f "%Y-%m-%d" "$argv[1]" +%Y-%m-%d 2>/dev/null)
        if test $status -ne 0
            # Try relative dates like "yesterday"
            set target_date (date -v-1d +%Y-%m-%d 2>/dev/null)
            if test "$argv[1]" != "yesterday"
                echo "Usage: twed [YYYY-MM-DD|yesterday]"
                return 1
            end
        end
        set display_date "$target_date"
    end

    set -l tmpfile (mktemp /tmp/twed.XXXXXX.txt)
    set -l next_date (date -j -v+1d -f "%Y-%m-%d" "$target_date" +%Y-%m-%d)

    # Header with instructions
    echo "# Timewarrior entries for $display_date ($target_date)" > $tmpfile
    echo "# Format: HH:MM - HH:MM tag1 tag2" >> $tmpfile
    echo "#         HH:MM - now   tag1  (for currently active)" >> $tmpfile
    echo "# Lines starting with # are ignored" >> $tmpfile
    echo "" >> $tmpfile

    # Export entries for the target day
    set -l has_entries false
    for line in (timew export $target_date - $next_date 2>/dev/null | python3 -c "
import sys, json
data = json.load(sys.stdin)
for e in data:
    start = e['start']
    sh = start[9:11] + ':' + start[11:13]
    if 'end' in e:
        end = e['end']
        eh = end[9:11] + ':' + end[11:13]
    else:
        eh = 'now'
    tags = ' '.join(e.get('tags', []))
    print(f'{sh} - {eh} {tags}')
")
        echo $line >> $tmpfile
        set has_entries true
    end

    if not $has_entries
        echo "09:00 - 09:15 standup" >> $tmpfile
    end

    # Checksum before edit
    set -l before (md5 -q $tmpfile)

    # Open in editor
    $EDITOR $tmpfile

    # Checksum after edit
    set -l after (md5 -q $tmpfile)

    if test "$before" = "$after"
        echo "No changes."
        rm $tmpfile
        return
    end

    # Parse edited file and reconcile
    # First: delete all entries for the target day
    set -l ids (timew export $target_date - $next_date 2>/dev/null | python3 -c "
import sys, json
data = json.load(sys.stdin)
for e in data:
    print(e['id'])
")

    # Stop active tracking if any (to avoid conflicts)
    timew stop 2>/dev/null

    # Delete old entries (highest ID first to avoid shifting)
    for id in (echo $ids | tr ' ' '\n' | sort -rn)
        echo y | timew delete @$id 2>/dev/null
    end

    # Recreate from buffer
    set -l count 0
    set -l errors 0
    for line in (grep -v '^#' $tmpfile | grep -v '^\s*$')
        set -l start_time (echo $line | sed -E 's/^([0-9]{1,2}:[0-9]{2}).*/\1/')
        set -l end_time (echo $line | sed -E 's/^[0-9]{1,2}:[0-9]{2}[ ]*-[ ]*([0-9]{1,2}:[0-9]{2}|now).*/\1/')
        set -l tags (echo $line | sed -E 's/^[0-9]{1,2}:[0-9]{2}[ ]*-[ ]*([0-9]{1,2}:[0-9]{2}|now)[ ]*//')

        if test "$end_time" = "now"
            timew track {$target_date}T{$start_time}:00 - now $tags
        else
            timew track {$target_date}T{$start_time}:00 - {$target_date}T{$end_time}:00 $tags
        end
        if test $status -eq 0
            set count (math $count + 1)
        else
            set errors (math $errors + 1)
            echo "FAILED: $line"
        end
    end

    echo "Wrote $count entries for $target_date."
    if test $errors -gt 0
        echo "WARNING: $errors entries failed."
    end
    rm $tmpfile
end
