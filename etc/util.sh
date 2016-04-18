#!/bin/bash

has() {
  which "$1" > /dev/null 2>&1
  return $?
}

is_bash() {
    [ -n "$BASH_VERSION" ]
}

is_zsh() {
    [ -n "$ZSH_VERSION" ]
}

ostype() {
    uname | tr "[:upper:]" "[:lower:]"
}

# os_detect() {
#     case $(ostype) in
#         *'linux'*)  PLATFORM='linux'   ;;
#         *'darwin'*) PLATFORM='osx'     ;;
#         *'bsd'*)    PLATFORM='bsd'     ;;
#         *)          PLATFORM='unknown' ;;
#     esac
#     export PLATFORM
# }

# is_osx() {
#     os_detect
#     if [ $PLATFORM = 'osx' ]; then
#         return 0
#     else
#         return 1
#     fi
# }

# is_linux() {
#     echo "yeah"
# }

