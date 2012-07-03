#
# zshrc
#

# emacs key bindings
bindkey -e

functions locallib () {
    INSTALL_BASE=$1
    if [ -d $INSTALL_BASE ] ; then
        eval $(~/bin/use-locallib $INSTALL_BASE)
    fi
}

# For screen
if [ "$TERM" = "screen" ]; then
    preexec() {
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        echo -n "k$cmd[1]:t\\"
    }
    precmd() { echo -n "k[`basename $PWD`]\\" }
fi

###
# Set options
###
setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys

HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
function history-all { history -E 1 }

#####
# Set aliases
#####
case ${OSTYPE} in
    darwin*)
        [ -f ~/dotfiles/.zshrc.osx ] && source ~/dotfiles/.zshrc.osx
        ;;
    linux*)
        [ -f ~/dotfiles/.zshrc.linux ] && source ~/dotfiles/.zshrc.linux
        ;;
esac

alias ..='cd ..'
alias ...='cd ~'
alias vi='vim'
alias rsync_ex_svn="rsync -avz --exclude=\".svn\""
alias rsync_ex_git="rsync -avz --exclude=\".git\""
alias ss='screen -U'
alias sl='screen -ls'
alias sr='screen -r'
alias be='bundle exec '

alias -g G='| grep -v grep | grep --color=auto '
alias -g V='| vim -'
alias -g L='| less'
alias -g T='| tail -f'

alias -g CD='| colorize diff | less -R'

alias be='bundle exec '

function mscreen() {
    if [ $# -lt 1 ]
    then
        echo input Session name
    else
        screen -S  $1
    fi
}

###
# Set prompt
###
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'

setopt prompt_subst
case ${UID} in
0)
    ;;
*)
    PROMPT_COLOR=31
    precmd(){
        PROMPT_COLOR="$[31+(${PROMPT_COLOR}-30)%7]"
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
        [[ -n "$PERLBREW_PERL" ]] && psvar[2]="$PERLBREW_PERL"
        [[ -n "$PERL_LOCAL_LIB_ROOT" ]] && psvar[3]="$PERL_LOCAL_LIB_ROOT"
    }
    PROMPT='%{[${PROMPT_COLOR}m%}%B%U[%n@%m]%b%u%{[m%}%1(v|%F{green}%1v%f|)%2(v|%F{yellow}[perlversion:%2v]%f|)%3(v|%F{magenta}(locallib:%3v%)%f|)'"
%(!.#.$)"
    RPROMPT='[%F{cyan}%~%{[m%}$f]'
    ;;
esac

###
# Set colors
###
autoload -U colors
colors

###
# Set compinit 
###
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache true

fpath=($HOME/zsh.d/functions(N-/) $fpath)
typeset -U FPATH
typeset -U PATH

autoload -U compinit
if [ "$CYGWIN" ] ; then
    compinit -u
else
    compinit
fi

r() {
    local f
    f=($HOME/zsh.d/functions/*(.))
    unfunction $f:t 2> /dev/null
    autoload -U $f:t
}

setopt COMPLETE_IN_WORD
export EDITOR=/usr/bin/vim

###
# Perl setting
###
alias perlsource="PAGER=/usr/bin/vim perldoc -m "

perlpath () {
    perldoc -l $@
#     for MODULE in $@
#     do
#         perl -MClass::Inspector -le "print Class::Inspector->resolved_filename(qq{$MODULE})"
#     done
#     MODULE=
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
