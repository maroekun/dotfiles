export _Z_CMD=z
function peco-frequently-visited-directory(){
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi

    local selected_dir=$(z | eval $tac | awk '{print $2}' | peco)

    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-frequently-visited-directory
bindkey '^]^f' peco-frequently-visited-directory
