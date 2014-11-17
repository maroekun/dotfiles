export _Z_CMD=z
function peco-frequently-visited-directory(){
    local selected_dir=$(z | tail -r | awk '{print $2}' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-frequently-visited-directory
bindkey '^]^f' peco-frequently-visited-directory
