#!/usr/bin/zsh

DOT_FILES=(.zshrc .vimrc .screenrc .bashrc .tmux.conf .railsrc .gitconfig.local)

CURRENT=`pwd`

for file in ${DOT_FILES[@]}
do
  if test -e $HOME/$file ;then
    echo $file is exist.
  else
    ln -s $CURRENT/$file $HOME/$file
    echo $file sym create.
  fi
done
