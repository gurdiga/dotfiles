#!/bin/sh

MY_PATH=`readlink -f $0`
DIR=`dirname $MY_PATH`

ln -s $DIR/.gitconfig $DIR/.gitignore $DIR/.vimrc $DIR/.aliases $DIR/.fonts.conf $DIR/gpl $DIR/vimp ~/ && \
	echo "Created symbolic links."

if [ -d ~/.mozilla/firefox ]; then
	ln -s $DIR/userContent.css ~/.mozilla/firefox/*.default/chrome/
fi

if [ ! -f ~/.vimrc_local ]; then
	touch ~/.vimrc_local
fi

fgrep '.aliases' ~/.bashrc || \
	echo ". ~/.aliases" >> ~/.bashrc
