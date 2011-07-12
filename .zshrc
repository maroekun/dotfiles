## set export
## For macports
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH
## For android-sdk tools
export PATH=$PATH:/Applications/android-sdk-mac_x86/tools
export LSCOLORS="DxGxcxdxCxegedabagacad"

## set aliases
alias ll='/bin/ls -laF -G'
alias ls='/bin/ls -l -G'
alias l='/bin/ls -F -G'
alias ..='cd ..'
alias ...='cd ~'
alias ms='makeScreen'
alias sl='screen -ls'
alias sr='screen -r'
alias vi='/usr/bin/vim'
alias github='cd ~/git/github/'
alias pmversion='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} || "not found" }'"'"
alias perlsource="PAGER=vim perldoc -m "

alias -g G='| grep --color=auto '
alias -g L='|less'
alias -g T='|tail -f'

## set options for zsh
#fpath=($HOME/.zsh/functions(N-) $fpath)
#typeset -U fpath
autoload -U compinit
compinit -u
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

#if [ "$TERM" = "screen" ]
#then
#    preexec(){
#        emulate -L zsh
#        local -a cmd; cmd=(${(z)2})
#        echo -n "^[k$cmd[1]:t^[\\"
#    }
#fi

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

#function printKnownHosts() {
#    if [ -f $HOME/.ssh/known_hosts ];then
#        cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
#    fi
#}
#_cache_hosts=($(printKnownHosts))
#function choseCompletionSSH() {
#    if [ -f $HOME/.ssh/config ]; then
#        cat $HOME/.ssh/config | grep -v '#' | grep 'Host ' | awk '{print $2}'
#    fi
#}
#_cache_hosts=($(choseCompletionSSH))
#if [ -f $HOME/.ssh/known_hosts ]; then
#    hostnames=(`perl -ne 'if (/^([a-zA-Z0-9.-]+)/) { print "$1\n";}' ~/.ssh/known_hosts`)
#elif [ -f /etc/hosts ]; then
#    hostnames=(`awk '{print $2}' /etc/hosts`)
#else
#    hostnames=(localhost)
#fi

perlpath () {
    for MODULE in $@
    do
        perl -MClass::Inspector -le "print Class::Inspector->resolved_filename(qq{$MODULE})"
     done
     MODULE=
}

perlversion () {
    for MODULE in $@
    do
        perl -le "eval { require $MODULE}; print qq{${MODULE}: \$${MODULE}::VERSION}"
    done
    MODULE=
}

cpan-uninstall() {
    for MODULE in $@
    do
        ${_SUDO} perl -MConfig -MExtUtils::Install -e '($FULLEXT=shift)=~s{::}{/}g;uninstall "$Config{sitearchexp}/auto/$FULLEXT/.packlist",1' $MODULE
    done
}

source /Users/maroekun/perl5/perlbrew/etc/bashrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
