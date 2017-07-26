# rquire: ghq command
function peco-ghq-cd() {
  local t_dir=$(ghq list | peco)

  if [ -n "$t_dir" ] ; then
    BUFFER="cd $(ghq root)/${t_dir}"
    zle accept-line
  fi
}

zle -N peco-ghq-cd
bindkey '^]^g' peco-ghq-cd
