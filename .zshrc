## set aliases
alias ll='/bin/ls -laF --color=tty'
alias ls='/bin/ls -l --color=tty'
alias l='/bin/ls -F --color=tty'
alias ..='cd ..'
alias ...='cd ~'
alias s='makeScreen'
alias sl='screen -ls'
alias sr='screen -r'
alias vi='/usr/bin/vim'
alias pmversion='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} || "not found" }'"'"

alias -g G='| grep '
alias -g L='|less'
alias -g T='|tail -f'

## set options for zsh
autoload -U compinit
setopt COMPLETE_IN_WORD
setopt AUTO_CD

# set terminal title including current directory
case "${TERM}" in
    kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

case ${UID} in
0)
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT_COLOR=31
    precmd() {
        PROMPT_COLOR="$[31+(${PROMPT_COLOR}-30)%7]";
        PROMPT="%{[${PROMPT_COLOR}m%}%U%n@$HOST""%u%{[m%} %(!.#.$)";
        RPROMPT="[%{[${PROMPT_COLOR}m%}%~%{[m%}]";
    }
    ;;
esac

if [ "$TERM" = "screen" ]
then
    preexec(){
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        echo -n "^[k$cmd[1]:t^[\\"
    }
fi

## display color
function pcolor() {
    for ((f = 0; f < 255; f++)); do
        printf "\e[38;5;%dm %3d#\e[m" $f $f
    if [[ $f%8 -eq 7 ]] then
        printf "\n"
    fi
    done
    echo
} 

function makeScreen() {
    if [ $# -lt 1  ]
    then
        echo input Session name
    else
        screen -S $1 
    fi
}