#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -v -s $DIR/.gitconfig $DIR/.gitignore $DIR/.vimrc $DIR/.aliases $DIR/.bashrc.my $DIR/vimp $DIR/.mplayer $DIR/.screenrc $DIR/.irbrc ~/

if [ -d ~/.mozilla/firefox ]; then
	ln -s $DIR/userContent.css ~/.mozilla/firefox/*.default/chrome/
fi

if [ ! -f ~/.vimrc_local ]; then
	touch ~/.vimrc_local
fi

fgrep '.aliases' ~/.bashrc || \
	echo ". ~/.aliases" >> ~/.bashrc

fgrep '.bashrc.my' ~/.bashrc || \
	echo ". ~/.bashrc.my" >> ~/.bashrc

mkdir -p ~/.vim/autoload ~/.vim/bundle

wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O ~/.vim/autoload/pathogen.vim

git clone https://github.com/Shutnik/jshint2.vim.git ~/.vim/bundle/jshint2.vim
git clone https://github.com/tpope/vim-fugitive.git  ~/.vim/bundle/vim-fugitive
git clone https://github.com/othree/xml.vim.git      ~/.vim/bundle/xml.vim
