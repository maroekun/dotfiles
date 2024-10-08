#
# zshrc
#

# emacs key bindings
bindkey -e

functions locallib () {
    INSTALL_BASE=$1
    if [ -d $INSTALL_BASE ] ; then
        eval $(~/bin/bin/use-locallib $INSTALL_BASE)
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
setopt hist_ignore_dups
function history-all { history -E 1 }

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

# NOTE: starthipと入れ替え
# [ -f ~/zsh.d/.zshrc.prompt ] && source ~/zsh.d/.zshrc.prompt

###
# dircolors
###
eval $(gdircolors ~/zsh.d/dircolors/dircolors.256dark)

###
# Set compinit 
###
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache true

typeset -U path fpath
fpath=(
  $HOME/zsh.d/functions(N-/)
  $fpath
)
autoload -U compinit

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit

  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ "$CYGWIN" ] ; then
    compinit -u
else
    compinit -u
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
perlsource () {
    perldoc m $@ | vim -R -
}

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

###
# git alias and function
###
[ -f ~/.zshrc.git ] && source ~/.zshrc.git
[ -f ~/.zshrc.docker ] && source ~/.zshrc.docker
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
case ${OSTYPE} in
    darwin*)
        [ -f ~/.zshrc.osx ] && source ~/.zshrc.osx
        ;;
    linux*)
        [ -f ~/.zshrc.linux ] && source ~/.zshrc.linux
        ;;
esac

###
# fzf setting
###
if whence -p fzf >/dev/null ; then
    for f (~/zsh.d/fzf/*.zsh) source ${f}
fi

###
# source zsh-syntax-highlighting
###
[ -f ~/zsh.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/zsh.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###
# NOTE: starship: プロンプトカスタマイズ
###
eval "$(starship init zsh)"
