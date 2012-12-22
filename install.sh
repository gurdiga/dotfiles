#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -v -s $DIR/.gitconfig $DIR/.gitignore $DIR/.vimrc $DIR/.aliases $DIR/vimp $DIR/.mplayer $DIR/.screenrc ~/

if [ -d ~/.mozilla/firefox ]; then
	ln -s $DIR/userContent.css ~/.mozilla/firefox/*.default/chrome/
fi

if [ ! -f ~/.vimrc_local ]; then
	touch ~/.vimrc_local
fi

fgrep '.aliases' ~/.bashrc || \
	echo ". ~/.aliases" >> ~/.bashrc


if [ ! -d ~/.vim/ftplugin ]; then
  mkdir -p ~/.vim/ftplugin
fi

if [ ! -f ~/.vim/ftplugin/xml.vim ]; then
  wget https://raw.github.com/sukima/xmledit/master/ftplugin/xml.vim -O ~/.vim/ftplugin/xml.vim
  ln -vs ~/.vim/ftplugin/xml.vim ~/.vim/ftplugin/html.vim
fi
