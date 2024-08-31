fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "/opt/homebrew/bin"
fish_add_path "/opt/homebrew/sbin"
fish_add_path "$HOME/.fzf/bin"
fish_add_path "/opt/homebrew/Cellar/docker/23.0.5/bin"

## Environment
# Shell only exists after the 10th consecutive Ctrl-d
# export IGNOREEOF=10

# set fish_greeting
set fish_greeting

set -gx EDITOR nvim
# set -g IGNOREEOF 3

set -g NVM_DIR ~/.nvm
# bass source /opt/homebrew/opt/nvm/nvm.sh # This loads nvm
# bass sourcen/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm # This loads nvm bash_completion

set -gx HISTSIZE 10000
set -gx HISTCONTROL ignoredups


# fzf default command
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow'

# elixir shell
set -gx ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"
# include local headers/libs on C compilation
# set -gx C_INCLUDE_PATH $HOME/.local/include
# set -gx CPLUS_INCLUDE_PATH $HOME/.local/include
# set -gx LIBRARY_PATH $HOME/.local/lib


# Load aliases
. ~/.config/fish/aliases.fish

# My abbreviations
if status --is-interactive
  # Quick edits
  abbr --add --global eali 'nvim ~/.config/fish/aliases.fish'
  abbr --add --global efish 'nvim ~/.config/fish/config.fish'
  abbr --add --global egitc 'nvim ~/.gitconfig'
  abbr --add --global envim 'nvim ~/.config/nvim/init.lua'
  abbr --add --global etmux 'nvim ~/.tmux.conf'
  abbr --add --global essh 'nvim ~/.ssh/config'
  abbr --add --global eala 'nvim ~/.config/alacritty/alacritty.toml'
  abbr --add --global twork '~/.config/scripts/work-tmux.sh'
  abbr --add --global tdev '~/.config/scripts/dev-tmux.sh'

  if command -v nvim > /dev/null
    abbr -a vim 'nvim'
  end

  if command -v tmux > /dev/null
    abbr -a tm 'tmux'
  end

  if command -v btm > /dev/null
    abbr -a btm 'btm --battery'
  end

  if command -v bartib > /dev/null
    abbr -a btb 'bartib'
    abbr -a btbl 'bartib list --today'
    abbr -a btbr 'bartib report --today'
  end

  if command -v eza > /dev/null
    abbr -a l 'eza'
    abbr -a ls 'eza'
    abbr -a ll 'eza -l'
    abbr -a la 'eza -la --icons=always --git --header'
    abbr -a tree 'eza -T -L 2'
  else
    abbr -a l 'ls'
    abbr -a ll 'ls -lh'
    abbr -a la 'ls -lha'

    abbr --add --global lh 'ls -lhaFG'
  end

  if command -v task > /dev/null
    abbr -a t 'task'
    abbr -a tsh 'tasksh'
  end

  if command -v zoxide > /dev/null
    # configure zoxide
    zoxide init fish | source
    abbr -a cd 'z'
  end

  abbr --add --global mv 'mv -i'
  abbr --add --global cp 'cp -i'
  abbr --add --global ln 'ln -is'

  # archives
  abbr --add --global tgz 'tar -xvzf' # extract .tar.gz
  abbr --add --global tbz 'tar -xvjf' # extract .tar.bz2

  abbr --add --global wifi "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI | tr -s ' ' | cut -d ' ' -f 3"
end
