# require $memo_dir
# e.g.) export memo_dir=~/Documents/memo
function peco-select-memo() {
  local m_file=$(/usr/bin/find ${memo_dir:-.} | peco)

  if [ -n "$m_file" ] ; then
        BUFFER="vim ${m_file}"
        zle accept-line
  fi
}
zle -N peco-select-memo
bindkey '^]^m' peco-select-memo
