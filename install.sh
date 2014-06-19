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

wget --no-check-certificate https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O ~/.vim/autoload/pathogen.vim

repos="Shutnik/jshint2.vim tpope/vim-fugitive othree/xml.vim JulesWang/css.vim cakebaker/scss-syntax.vim digitaltoad/vim-jade"

for repo in $repos; do
  dir=~/.vim/bundle/$(basename $repo)

  if [ -d $dir ]; then
    continue
  fi

  git clone https://github.com/$repo.git $dir
done
