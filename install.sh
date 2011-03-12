#!/bin/sh

MY_PATH=`readlink -f $0`
DIR=`dirname $MY_PATH`

ln -s $DIR/.gitconfig $DIR/.vimrc $DIR/.aliases ~/ && \
	echo ".gitconfig .vimrc"

fgrep '.aliases' ~/.bashrc || \
	echo ". ~/.aliases" >> ~/.bashrc

. ~/.aliases
