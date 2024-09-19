# require $memo_dir
# e.g.) export memo_dir=~/Documents/memo

function fzf-memo() {
  if [ -z "$memo_dir" ]; then
    echo "Please set memo_dir"
    return 1
  fi

  local m_file=$(/usr/bin/find ${memo_dir} | fzf +m)

  if [ -n "$m_file" ] ; then
    BUFFER="vim ${m_file}"
    zle accept-line
  fi
}

zle -N fzf-memo
bindkey '^]^m' fzf-memo
