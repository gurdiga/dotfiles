#!/bin/sh

DIR=`pwd`

ln -s $DIR/.gitconfig $DIR/.vimrc ~/ && \
	echo ".gitconfig .vimrc"

fgrep '.aliases' ~/.bashrc || \
	echo ". $DIR/.aliases" >> ~/.bashrc

. $DIR/.aliases
