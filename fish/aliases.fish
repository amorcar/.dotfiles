# My aliases
alias reload '. ~/.config/fish/config.fish'

# simple ip
alias ip1="ipconfig getifaddr en0"
alias ip2 "ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
# more details
alias ip3 "ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# external ip
alias ip4 "curl ipinfo.io/ip"
#router IP
alias ip5 "netstat -rn | grep default"

# grep with color
alias grep 'grep --color=auto'
export GREP_COLOR='0;36'

# Get homebrew installed packages sizes
alias brew_pack_size 'brew list | xargs brew info | grep Cellar'
# alias brew_pack_size "bash brew list | xargs brew info | grep Cellar | cut -d'/' -f5,6 | sed 's/\/.*\,//' | sed 's/ / - /' | sed 's/...$//'"

# Flush dns
alias flush_dns "sudo killall -HUP mDNSResponder"

alias tmd "~/.config/scripts/dev-tmux.sh"

alias dnstest 'zsh ~/.config/scripts/dnstest.sh |sort -k 22 -n'

alias airport '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

alias lzd 'lazydocker'
alias lzs 'lazysql'
