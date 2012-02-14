#!/bin/sh

DOT_FILES=( .zshrc .vimrc .screenrc .bashrc )

for file in ${DOT_FILES[@]}
do
  if test -e $HOME/$file ;then
    echo $file is exist.
  else
    ln -s $HOME/dotfiles/$file $HOME/$file
    echo $file sym create.
  fi
done
