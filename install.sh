#/bin/bash

# utility
error() {
   echo "$@" 1>&2
}

abort() {
  echo "$@" 1>&2
  exit 1;
}

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

# paint utility
p_color() {
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

e_newline() {
  printf "\n"
}

e_header() {
  printf " \033[37;1m%s\033[m\n" "$*"
  # p_color gray " $*"
  # e_newline
}
e_warning() {
  printf " \033[31m%s\033[m\n" "$*"
  # p_color red " $*"
  # e_newline
}

e_done() {
  printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"
  # p_color gray " ✔ $*";
  # printf "...";
  # p_color green "OK"
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
    p_color gray "["
    p_color gray "$(date +%H:%M:%S)"
    p_color gray "] "
  }
  ts; p_color "$color" "$2"; echo
}

log_f() {
  logg ERROR "$1" 1>&2
}

log_s() {
  logg SUCCESS "$1"
}

# process
# Set default $DOTPATH
var_init() {
  e_newline && e_header "Setup variables..."
  if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/dotfiles; export DOTPATH
  fi

  e_header "... DOTPATH is ${DOTPATH}"

  if [ -z "${GITHUB_DOTFILE:-}" ]; then
    GITHUB_DOTFILE="https://github.com/maroekun/dotfiles"
  fi
  if [ -z "${GITHUB_BRANCH:-}" ]; then
    GITHUB_BRANCH="master"
  fi
  GITHUB_DOTFILE_REPO="${GITHUB_DOTFILE}.git"; export GITHUB_DOTFILE_REPO
  GITHUB_DOTFILE_BRANCH="${GITHUB_BRANCH}"; export GITHUB_DOTFILE_BRANCH
  GITHUB_DOTFILE_ARCHIVE="${GITHUB_DOTFILE}/archive/${GITHUB_BRANCH}.tar.gz" export GITHUB_DOTFILE_ARCHIVE
  e_header "... Github REPO is ${GITHUB_DOTFILE_REPO}"
  e_header "... Github repository ARCHIVE is ${GITHUB_DOTFILE_ARCHIVE}"

  e_newline && e_done "Setup"
}

dotfiles_download() {
  e_newline && e_header "Download dotfiles..."

  if [ -d "$DOTPATH" ]; then
    log_f "$DOTPATH: already exists"
    exit 1
  fi

  if has "git" ; then
    git clone --recursive "$GITHUB_DOTFILE_REPO" "$DOTPATH"

  elif has "curl" || has "wget"; then
    if has "curl"; then
      curl -L "$GITHUB_DOTFILE_ARCHIVE"
    elif has "wget"; then
      wget -O - "$GITHUB_DOTFILE_ARCHIVE"
    fi | tar xvz

    if [ ! -d dotfiles-master ]; then
      log_f "dotfiles-master: not found"
      exit 1
    fi
    command mv -f dotfiles-master "$DOTPATH"
  else
    log_f "curl or wget required"
    exit 1
  fi
  e_newline && e_done "Download"
}

dotfiles_deploy() {
  e_newline && e_header "Deploy dotfiles..."

  if [ ! -d "$DOTPATH" ]; then
    log_f "$DOTPATH: not found"
    exit 1
  fi

  cd "$DOTPATH"
  make deploy &&
    e_newline && e_done "Deploy"
}
dotfiles_init() {
  if [ "$1" == "init" ]; then
    e_newline && e_header "Init dotfiles..."

    make init

    e_newline && e_done "Init"
  fi
}

run() {
  var_init &&
  dotfiles_download &&
  dotfiles_deploy &&
  dotfiles_init "$@"
}

run "$@"
