#!/bin/bash

paint() {
  local open="\033["
  local close="${open}0m"
  local red="1;31m"
  local yellow="1;33m"
  local green="1;32m"
  local gray="0;37m"

  local text=$2
  local color="$close"
  case "$1" in
    red | gray | yellow | green)
    eval color="\$$1"
    ;;
  esac

  printf "${open}${color}${text}${close}"
}
