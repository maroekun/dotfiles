#!/usr/bin/zsh

CURRENT=$(cd $(dirname $0); pwd)
DOT_FILES=(.zshrc .vimrc .screenrc .bashrc .tmux.conf .perltidyrc .railsrc .gitconfig.local .gemrc zsh.d .zshrc.osx .zshrc.linux .zshrc.git)
DOTT_FILES=(perlcriticrc replyrc rubocop.yml)
DOT_DIRS=(zsh.d .selfvim)

if test ! -e $HOME/dotfiles ; then
    echo 'dotfiles not exists!!'
    echo 'create sym-link to your $HOME'
    ln -s $CURRENT $HOME/dotfiles
fi

cat <<END

+ ----------------------------------------------- +
  Create rc file
+ ----------------------------------------------- +

END

for file in ${DOT_FILES[@]}
do
  if test -e $HOME/$file ;then
    echo Skip: $HOME/$file is exist.
  else
    ln -s $CURRENT/$file $HOME/$file
   echo $file sym-link create.
  fi
done

for file in ${DOTT_FILES[@]}
do
  if test -e $HOME/.$file ;then
    echo Skip: $HOME/$file is exist.
  else
    ln -s $CURRENT/$file $HOME/.$file
   echo $file sym-link create.
  fi
done

cat <<END

+ ----------------------------------------------- +
  Submodule Initialize.
+ ----------------------------------------------- +

END

file_num=`expr $(/bin/ls $CURRENT/dot.vim/neobundle.vim | wc -l)`
if [ $file_num -eq 0 ] ; then
  echo $CURRENT/dot.vim/neobundle.vim is empty
  cd $CURRENT
  git submodule update --init
else
  echo Skip: $CURRENT/dot.vim/neobundle.vim already initialize.
fi

cat <<END

+ ----------------------------------------------- +
  Create directory
+ ----------------------------------------------- +

END

if [ ! -e $HOME/.vim ] ; then
  mkdir -p $HOME/.vim/bundle
  echo $HOME/.vim create.
  ln -s $CURRENT/dot.vim/neobundle.vim $HOME/.vim/bundle/neobundle.vim
else
  echo Skip: $HOME/.vim is exist.
fi

if [ ! -e $HOME/.vim/dict ] ; then
  ln -s $CURRENT/dict $HOME/.vim/dict
fi

if [ ! -e $HOME/.peco ] ; then
  mkdir -p $HOME/.peco
  ln -snf $CURRENT/peco-config.json $HOME/.peco/config.json
else
  echo Skip: $HOME/.peco is exist.
fi

for d in ${DOT_DIRS[@]}
do
  if [ ! -e $HOME/$d ] ; then
    ln -s $CURRENT/$d $HOME/$d
  else
    echo Skip: $HOME/$d is exist.
  fi
done

if [ ! -e $HOME/bin ]; then
  mkdir $HOME/bin
  echo $HOME/bin create.
fi

if [ ! -e $HOME/bin/bin ]; then
  ln -s $CURRENT/bin $HOME/bin/bin
fi

if [ ! -e $HOME/.ctags ]; then
  ln -s $CURRENT/_ctags $HOME/.ctags
fi


cat <<END

-------------------------------------------------

add "export PATH=\$HOME/bin/bin:\$PATH" in your .zshenv or .bash_profile

-------------------------------------------------

END
