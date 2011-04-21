#!/bin/sh

MY_PATH=`readlink -f $0`
DIR=`dirname $MY_PATH`

ln -s $DIR/.gitconfig $DIR/.gitignore $DIR/.vimrc $DIR/.aliases ~/ && \
	echo ".gitconfig .gitignore .vimrc .aliases"

fgrep '.aliases' ~/.bashrc || \
	echo ". ~/.aliases" >> ~/.bashrc

. ~/.aliases
