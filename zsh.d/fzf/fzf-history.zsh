function fzf-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | sort -u | \
        eval $tac | \
        fzf --query "$LBUFFER")
    CURSOR=$#BUFFER
}

zle -N fzf-history
bindkey '^r' fzf-history
