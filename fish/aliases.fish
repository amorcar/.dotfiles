alias reload '. ~/.config/fish/config.fish'

# grep with color
alias grep 'grep --color=auto'
set -gx GREP_COLOR '0;36'

# Get week number
alias week='date +%V'

# Flush dns
alias flush_dns "sudo killall -HUP mDNSResponder"

# local ip
alias localip="ipconfig getifaddr en0"
# alias localip "ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
# more details
alias ipinfo "ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# external ip
alias ip "dig +short myip.opendns.com @resolver1.opendns.com"
# alias ip "curl ipinfo.io/ip"
#router IP
alias iproute "netstat -rn -f inet | grep default"

alias oil '~/.config/scripts/oil-ssh.sh'

if command -v task > /dev/null
  alias tsw 'task'
end

if command -v timew > /dev/null
  alias tmw 'timew'
end

if command -v lazydocker > /dev/null
  alias lzd 'lazydocker'
end

if command -v lazysql > /dev/null
  alias lzs 'lazysql'
end

if command -v ncspot > /dev/null
  alias play "echo 'playpause' | nc -U /tmp/ncspot-(id -u)/ncspot.sock > /dev/null"
  alias pause "echo 'playpause' | nc -U /tmp/ncspot-(id -u)/ncspot.sock > /dev/null"
end

if command -v csvlens > /dev/null
  alias csv 'csvlens'
end


if command -v uv > /dev/null
  alias ipython 'PREFECT_API_URL="http://127.0.0.1:4200/api" ENVIRONMENT=prod uv run ipython'
end

