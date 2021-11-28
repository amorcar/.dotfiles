fish_add_path "$HOME/.cargo/bin"
fish_add_path "/opt/homebrew/bin"
fish_add_path "$HOME/.fzf/bin"


# set fish_greeting
set fish_greeting

# Globals
set -gx EDITOR nvim
# set -g IGNOREEOF 3

set HISTSIZE 10000
set HISTCONTROL ignoredups

# configure zoxide
zoxide init fish | source

# fzf default command
set FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow'

# Load aliases
. ~/.config/fish/aliases.fish

# My abbreviations
if status --is-interactive
  # Quick edits
  abbr --add --global eali 'nvim ~/.config/fish/aliases.fish'
  abbr --add --global efish 'nvim ~/.config/fish/config.fish'
  abbr --add --global egitc 'nvim ~/.gitconfig'
  abbr --add --global envim 'nvim ~/.config/nvim/init.vim'
  abbr --add --global etmux 'nvim ~/.tmux.conf'

  if command -v exa > /dev/null
    abbr -a l 'exa'
    abbr -a ls 'exa'
    abbr -a ll 'exa -l'
    abbr -a la 'exa -la'
    abbr -a tree 'exa -T -L 2'
  else
    abbr -a l 'ls'
    abbr -a ll 'ls -lh'
    abbr -a la 'ls -lha'

    abbr --add --global lh 'ls -lhaFG'
  end

  if command -v zoxide > /dev/null
    abbr -a cd 'z'
  end

  if command -v btm > /dev/null
    abbr -a btm 'btm --battery'
  end

  abbr --add --global mv 'mv -i'
  abbr --add --global cp 'cp -i'
  abbr --add --global ln 'ln -is'

  # archives
  abbr --add --global tgz 'tar -xvzf' # extract .tar.gz
  abbr --add --global tbz 'tar -xvjf' # extract .tar.bz2

  abbr --add --global wifi "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI | tr -s ' ' | cut -d ' ' -f 3"
end
