
alias r="rgfzf"
alias k="kubectl"
alias vim="nvim"
alias cat="bat"
alias da="direnv allow"

alias dot='/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias navi='navi --path ~/.config/navi'

alias ls='eza --color=always --no-filesize --icons=always --no-time --no-user --no-permissions'
alias ll='eza -ghla --classify=auto --group-directories-first --git'
alias lt='eza -ghlT --classify=auto --git'
alias lx='eza * --color always --icons=always --tree --group-directories-first --git-ignore'

alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# IP addresses
alias pubip='dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed -e "s/\"//g"'
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ips="sudo ifconfig -a | grep -o 'inet6\\? \\(addr:\\)\\?\\s\\?\\(\\(\\([0-9]\\+\\.\\)\\{3\\}[0-9]\\+\\)\\|[a-fA-F0-9:]\\+\\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# URL-encode strings
alias urlencode='python3 -c "import sys, urllib.parse as p; print(p.quote_plus(sys.argv[1]));"'

alias path='echo $PATH | tr -s ":" "\n"'
alias npm-exec='PATH=$(npm bin):$PATH'
alias clip='pbcopy'
alias findP="ps -ef | grep -v grep | grep "

alias weather="curl -4 http://wttr.in/Sofia"

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# tmux
alias tn='tmux new -s "${$(basename `PWD`)//./}" || tmux at -t "${$(basename `PWD`)//./}"'
alias attach="tmux attach -t"
alias clearTmux="clear && printf '\e[3J'"

# Download file with original filename
alias get="curl -O -L"
