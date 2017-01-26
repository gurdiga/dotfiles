#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -v -s "$DIR"/{.gitconfig,.gitignore,.vimrc,.aliases,.bashrc.my,vimp,.mplayer,.screenrc,.irbrc} ~/

if [ ! -f ~/.vimrc_local ]; then
	touch ~/.vimrc_local
fi

grep -F '.aliases' ~/.bashrc || \
	echo '. ~/.aliases' >> ~/.bashrc

grep -F '.bashrc.my' ~/.bashrc || \
	echo '. ~/.bashrc.my' >> ~/.bashrc

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/ftplugin

for f in "$DIR"/.vim/ftplugin/*; do
	ln -s -v "$f" ~/.vim/ftplugin/
done

mkdir -p ~/.vim/colors
for f in "$DIR"/.vim/colors/*; do
	ln -s -v "$f" ~/.vim/colors/
done

curl --silent https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim -o ~/.vim/autoload/pathogen.vim

repos="
	michaeljsmith/vim-indent-object
	othree/xml.vim
	tpope/vim-fugitive
	tpope/vim-surround
	tpope/vim-commentary
	tpope/vim-repeat
	cakebaker/scss-syntax.vim
	chase/vim-ansible-yaml
	groenewege/vim-less
	leafgarland/typescript-vim
	Quramy/tsuquyomi
	Shougo/vimproc.vim
	ElmCast/elm-vim
	Chiel92/vim-autoformat
"

for repo in $repos; do
	dir=~/.vim/bundle/$(basename "$repo")

	if [ ! -d "$dir" ]; then
		git clone https://github.com/"$repo".git "$dir"
	fi
done

# TypeScript support, as per https://github.com/Quramy/tsuquyomi#pathogen
cd ~/.vim/bundle/vimproc.vim && make
