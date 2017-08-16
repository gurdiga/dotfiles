#!/usr/bin/env bash

# See https://sipb.mit.edu/doc/safe-shell/
set -euf -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -f ~/.vimrc_local ]; then
	touch ~/.vimrc_local
fi

if [ ! -d ~/.vim/spell ]; then
	ln -s -v "$DIR"/.vim/spell ~/.vim/

	find ~/.vim/spell/ -name '*.add' | \
		xargs -I{} vim +":mkspell! {}|q" -
fi

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
	tpope/vim-rhubarb
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
	alvan/vim-closetag
	airblade/vim-gitgutter
"

for repo in $repos; do
	dir=~/.vim/bundle/$(basename "$repo")

	if [ ! -d "$dir" ]; then
		git clone https://github.com/"$repo".git "$dir"
	fi
done

# TypeScript support, as per https://github.com/Quramy/tsuquyomi#pathogen
cd ~/.vim/bundle/vimproc.vim && make

# vim-plug BEGIN
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim '+:PlugInstall|qa'
# vim-plug END

