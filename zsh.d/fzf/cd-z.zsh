export _Z_CMD=z

function fzf-z-cd(){
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi

    local selected_dir=$(z | eval $tac | awk '{print $2}' | fzf +m)

    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}

zle -N fzf-z-cd
bindkey '^]^f' fzf-z-cd

# vim: ft=bash
