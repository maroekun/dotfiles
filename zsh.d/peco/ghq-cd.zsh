# rquire: ghq command
function peco-ghq-cd() {
  local ghq
  if [ -x "`which ghq 2>/dev/null`" ]; then
      ghq=$(which ghq)
  else
      echo 'ghq command required'
      return 1
  fi
  echo $ghq

  local t_dir=$(ghq list | peco)
  if [ -n "$t_dir" ] ; then
    BUFFER="cd $(ghq root)/${t_dir}"
    zle accept-line
  fi
}

zle -N peco-ghq-cd
bindkey '^]^g' peco-ghq-cd
