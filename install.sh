#/bin/bash

source ./etc/log.sh
source ./etc/util.sh

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
  GITHUB_DOTFILE_REPO="${GITHUB_DOTFILE}.git"; export GITHUB_DOTFILE_REPO
  GITHUB_DOTFILE_ARCHIVE="${GITHUB_DOTFILE}/archive/master.tar.gz" export GITHUB_DOTFILE_ARCHIVE
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
