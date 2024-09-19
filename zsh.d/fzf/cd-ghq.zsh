# require: `ghq` command

function fzf-ghq-cd() {
    local GHQ_LIST=$(ghq list | sort -u | fzf +m)
    if [ -n "${GHQ_LIST}" ]; then
        BUFFER="cd $(ghq root)/${GHQ_LIST}"
    fi
    zle accept-line
}

zle -N fzf-ghq-cd
bindkey '^]^g' fzf-ghq-cd

# vim: ft=bash
