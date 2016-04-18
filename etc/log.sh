#!/bin/bash

source ./etc/color.sh

e_newline() {
  printf "\n"
}

e_header() {
  printf " \033[37;1m%s\033[m\n" "$*"
  # paint gray " $*"
  # e_newline
}
e_warning() {
  printf " \033[31m%s\033[m\n" "$*"
  # paint red " $*"
  # e_newline
}

e_done() {
  printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"
  # paint gray " ✔ $*";
  # printf "...";
  # paint green "OK"
  # e_newline
}

logg() {
  case "$1" in
    SUCCESS)
      color=green
      ;;
    ERROR | WARN)
      color=red
      ;;
    *)
      echo "hoge"
  esac

  ts() {
    paint gray "["
    paint gray "$(date +%H:%M:%S)"
    paint gray "] "
  }
  ts; paint "$color" "$2"; echo
}

log_f() {
  logg ERROR "$1" 1>&2
}

log_s() {
  logg SUCCESS "$1"
}
