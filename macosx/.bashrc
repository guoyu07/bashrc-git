#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  ---------------------------------------------------------------------------

# fix issue when upgrade grep to v2.21
# grep: warning: GREP_OPTIONS is deprecated; please use an alias or script
alias grep="/usr/bin/grep --color=auto --binary-files=without-match"

export HISTCONTROL=ignoredups
export HISTSIZE=1000
export HISTFILESIZE=1000

# iTerm2 custom title on each tab
export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"; history -a; history -r'

# PATH variable, configurated to work with npm and homebrew
# export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:~/bin:$PATH
export PATH=~/bin:$PATH
export GOPATH=~/Projects/gowork

# sets your computer to sleep immediatly
alias dodo="pmset sleepnow"
alias lsusb="system_profiler SPUSBDataType"

# retrieves the http status code for any URL
alias httpstatuscode="curl -w %{http_code} -s --output /dev/null $1"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

# opens file or folder with sublime
alias sublime='open -a "Sublime Text 2"'
# your public ip
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# your local ip
alias localip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
# removes a bunch of crap from your finder
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete && find . -name 'Thumbs.db' -type f -ls -delete"
# edit the virtual hosts apache configuration file
#alias editvhost="sudo nano /etc/apache2/extra/httpd-vhosts.conf"

# weather from my current location
alias weather="curl -s 'http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=en|us|brooklyn-ny|11215' | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'"

alias tolowercase="pbpaste | tr "[:upper:]" "[:lower:]" | pbcopy"
alias touppercase="pbpaste | tr "[:lower:]" "[:upper:]" | pbcopy"

# only show dot files
alias lsh="ls -ld .??*"

# opens up the IOS Simulator without launching xcode
alias iossimulator="(cd /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/ && open -a iPhone\ Simulator.app)"

# Calculates the gzip compression of a file
function gzipsize(){
	echo $((`gzip -c $1 | wc -c`/1024))"KB"
}

# Find files and ignore directories
function ff(){
  find . -iname $1 | grep -v .svn | grep -v .sass-cache
}

# GIT
function gitexport(){
	mkdir -p "$1"
	git archive master | tar -x -C "$1"
}

alias Gcd='cd $(git rev-parse --show-toplevel)'

# tab completion for ssh hosts
if [ -f ~/.ssh/known_hosts ]; then
    complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi

#S
PS1="[\[\033[36m\]\u\[\033[37m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]]$ "

# LESS man page colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# cd into the last focused finder window
function cdfinder(){
cd "$(osascript -e 'tell application "Finder"' \
  -e 'set myname to POSIX path of (target of window 1 as alias)' \
  -e 'end tell' 2>/dev/null)"
}

# Generates a random password
function randpassw() {
	if [ -z $1 ]; then
		MAXSIZE=10
	else
		MAXSIZE=$1
	fi
	array1=(
	q w e r t y u i o p a s d f g h j k l z x c v b n m Q W E R T Y U I O P A S D
	F G H J K L Z X C V B N M 1 2 3 4 5 6 7 8 9 0
	)
	# array1=(
	# q w e r t y u i o p a s d f g h j k l z x c v b n m Q W E R T Y U I O P A S D
	# F G H J K L Z X C V B N M 1 2 3 4 5 6 7 8 9 0
	# \! \@ \$ \% \^ \& \* \! \@ \$ \% \^ \& \* \@ \$ \% \^ \& \*
	# )
	MODNUM=${#array1[*]}
	pwd_len=0
	while [ $pwd_len -lt $MAXSIZE ]
	do
	    index=$(($RANDOM%$MODNUM))
	    echo -n "${array1[$index]}"
	    ((pwd_len++))
	done
	echo
}

#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

alias myip='curl ipv4.icanhazip.com'
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        # echo -e "\n${RED}Current network location :$NC " ; scselect
        # echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        # echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'
# /Applications 777 will cause VirtualBox startup failed
alias fixpermission='sudo chmod 755 /Applications'

# Macvim alias
# put to /usr/local/bin , such as gvim, vimdiff...
# alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

# some more ls aliases
# alias ls='ls -GFh'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias e="vim"
alias hexeditor='open -a ~/Applications/Hex\ Fiend.app/'

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
# export BLOCKSIZE=1k

#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

. ~/.rc/bashrc.common

# Macport install bash-completion
# if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
#     . /opt/local/etc/profile.d/bash_completion.sh
# fi

if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi

# add git support
if [ -f $HOME/.bashrc.local ]; then
	. $HOME/.bashrc.local
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
