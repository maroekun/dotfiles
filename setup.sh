#!/usr/bin/zsh

CURRENT=$(cd $(dirname $0); pwd)
DOT_FILES=(.zshrc .vimrc .screenrc .bashrc .tmux.conf .perltidyrc .railsrc .gitconfig.local .gemrc zsh.d .zshrc.osx .zshrc.linux .selfvim)

if test ! -e $HOME/dotfiles ; then
    echo 'dotfiles not exists!!'
    echo 'create sym-link to your $HOME'
    ln -s $CURRENT $HOME/dotfiles
fi

for file in ${DOT_FILES[@]}
do
  if test -e $HOME/$file ;then
    echo $file is exist.
  else
    ln -s $CURRENT/$file $HOME/$file
   echo $file sym-link create.
  fi
done

file_num=`expr $(/bin/ls $CURRENT/dot.vim/neobundle.vim | wc -l)`
if [ $file_num -eq 0 ] ; then
  echo $CURRENT/dot.vim/neobundle.vim is empty
  cd $CURRENT
  git submodule update --init
else
  echo $CURRENT/dot.vim/neobundle.vim already initialize.
fi

if [ ! -e $HOME/.vim ] ; then
  mkdir -p $HOME/.vim/bundle
  echo $HOME/.vim create.
  ln -s $CURRENT/dot.vim/neobundle.vim $HOME/.vim/bundle/neobundle.vim
else
  echo $HOME/.vim is exist.
fi

if [ ! -e $HOME/.selfvim ] ; then
  ln -s $CURRENT/.selfvim $HOME/.selfvim
else
  echo $HOME/.selfvim is exist.
fi

if [ ! -e $HOME/bin ]; then
  mkdir $HOME/bin
  echo $HOME/bin create.
fi

if [ ! -e $HOME/bin/bin ]; then
  ln -s $CURRENT/bin $HOME/bin/bin
fi


cat <<END
-------------------------------------------------

add "export PATH=\$HOME/bin/bin:\$PATH" in your .zshenv or .bash_profile

-------------------------------------------------
END
