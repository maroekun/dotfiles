function complete-ssh-host() {
    local host="$(command egrep -i '^Host\s+.+' $HOME/.ssh/config $(find $HOME/.ssh/conf.d -type f 2>/dev/null) | command egrep -v '[*?]' | awk '{print $2}' | sort | peco)"

    if [ ! -z "$host" ]; then
        LBUFFER+="$host"
    fi
    zle reset-prompt
}

zle -N complete-ssh-host
bindkey '^]h' complete-ssh-host
