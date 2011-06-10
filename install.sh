#!/bin/sh

MY_PATH=`readlink -f $0`
DIR=`dirname $MY_PATH`

ln -s $DIR/.gitconfig $DIR/.gitignore $DIR/.vimrc $DIR/.aliases $DIR/.fonts.conf $DIR/gpl ~/ && \
	echo "Created symbolic links."

fgrep '.aliases' ~/.bashrc || \
	echo ". ~/.aliases" >> ~/.bashrc
