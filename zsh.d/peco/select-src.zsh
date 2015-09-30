# require $memo_dir
# e.g.) export memo_dir=~/Documents/memo
function peco-select-src() {
  local m_dir=$(/bin/ls -d1 ~/src/* | peco)

  if [ -n "$m_dir" ] ; then
        BUFFER="cd ${m_dir}"
        zle accept-line
  fi
}
zle -N peco-select-src
bindkey '^]s' peco-select-src
