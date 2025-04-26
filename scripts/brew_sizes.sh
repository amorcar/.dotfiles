#/usr/env bash

echo '[info] collecting brew package sizes...'
brew list | xargs brew info 2>/dev/null | pv --gauge | grep Cellar | awk -F'/' '{
  pkg=$5;
  size_info=$NF;
  gsub(/^[0-9.-_]+ /, "", size_info);       # remove version numbers
  gsub(/\([0-9,]+ files, /, "", size_info); # remove number of files and open (
  gsub(/\).*/, "", size_info);              # remove closing )
  printf "%-20s : %s\n", pkg, size_info;
}' | sort -k 3 -h -r
