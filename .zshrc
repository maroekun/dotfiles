## set aliases
alias ls='/bin/ls -F --color=tty'
alias ll='/bin/ls -laF --color=tty'
alias l='/bin/ls -lF --color=tty'
alias ..='cd ..'
alias ...='cd ~'
alias ms='makeScreen'
alias sl='screen -ls'
alias sr='screen -r'
alias vi='/usr/bin/vim'
alias pmversion='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} || "not found" }'"'"
alias perlsource="PAGER=vim perldoc -m "

alias -g G='| grep --color=auto '
alias -g L='|less'
alias -g T='|tail -f'
alias -g V='|vim -'

## set options for zsh
#fpath=($HOME/.zsh/functions(N-) $fpath)
#typeset -U fpath

autoload -U colors
colors

autoload -U compinit
compinit

setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys
setopt COMPLETE_IN_WORD
setopt prompt_subst

# set terminal title including current directory
case "${TERM}" in
    kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'

case ${UID} in
0)
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT_COLOR=31
    precmd() {
        PROMPT_COLOR="$[31+(${PROMPT_COLOR}-30)%7]";
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
        [[ -n "$PERL_LOCAL_LIB_ROOT" ]] && psvar[2]="$PERL_LOCAL_LIB_ROOT"
    }
    PROMPT='%{[${PROMPT_COLOR}m%}%B%U[%n@%m]%b%u%{[m%}%1(v|%F{green}%1v%f|)%2(v|%F{magenta}(locallib:%2v%)%f|)'"
%(!.#.$)"
    RPROMPT='[%{[${PROMPT_COLOR}m%}%~%{[m%}]'

    ;;
esac

# case ${UID} in
# 0)
#     SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#     ;;
# *)
#     PROMPT_COLOR=31
#     precmd() {
#         PROMPT_COLOR="$[31+(${PROMPT_COLOR}-30)%7]";
#         PROMPT="%{[${PROMPT_COLOR}m%}%U%n@$HOST""%u%{[m%} %(!.#.$)";
#         RPROMPT="[`rprompt-git-current-branch`%{[${PROMPT_COLOR}m%}%~%{[m%}]"
#     }
#     ;;
# esac

###
# ssh setting 
###
if [ -f $HOME/.ssh/knows_hosts ]; then
    hostnames=(`perl -ne 'if (/^([a-zA-Z0-9.-]+)/) { print "$1\n";}' ~/.ssh/known_hosts`)
elif [ -f /etc/hosts ]; then
    hostnames=(`awk '{print $2}' /etc/hosts`)
else
    hostnames=(localhost)
fi

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

# cpan-uninstall() {
#     for MODULE in $@
#     do
#         ${_SUDO} perl -MConfig -MExtUtils::Install -e '($FULLEXT=shift)=~s{::}{/}g;uninstall "$Config{sitearchexp}/auto/$FULLEXT/.packlist",1' $MODULE
#     done
# }

# functions locallib () {
#     INSTALL_BASE=$1
#     if [ -d $INSTALL_BASE ] ; then
#         eval $(~/bin/use-locallib $INSTALL_BASE)
#     fi
# }

# autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

# function rprompt-git-current-branch {
#         local name st color gitdir action
#         if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
#                 return
#         fi
#         name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
#         if [[ -z $name ]]; then
#                 return
#         fi

#         gitdir=`git rev-parse --git-dir 2> /dev/null`
#         action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

#         st=`git status 2> /dev/null`
#         if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#                 color=%F{green}
#         elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
#                 color=%F{yellow}
#         elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
#                 color=%B%F{red}
#         else
#                  color=%F{red}
#         fi
#         echo "$color$name$action%f%b "
# }
