#!/usr/bin/zsh

CURRENT=$(cd $(dirname $0); pwd)
DOT_FILES=(.zshrc .vimrc .screenrc .bashrc .tmux.conf .railsrc .gitconfig.local .gemrc)

for file in ${DOT_FILES[@]}
do
  if test -e $HOME/$file ;then
    echo $file is exist.
  else
    ln -s $CURRENT/$file $HOME/$file
    echo $file sym create.
  fi
done

file_num=`expr $(/bin/ls $CURRENT/dot.vim/vundle.git | wc -l)`
if [ $file_num -eq 0 ] ; then
  echo $CURRENT/dot.vim/vundle.git is empty
  cd $CURRENT
  git submodule update --init
else
  echo $CURRENT/dot.vim/vundle.git already initialize.
fi

if [ ! -e $HOME/.vim ] ; then
  mkdir $HOME/.vim
  echo $HOME/.vim create.
  ln -s $CURRENT/dot.vim $HOME/.vim/vundle.git
else
  echo $HOME/.vim is exist.
fi
