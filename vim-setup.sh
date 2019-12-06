#!/usr/bin/env bash

echo "Setting up VIM..."

mkdir -p ~/.vim

# See https://sipb.mit.edu/doc/safe-shell/
set -eu -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -f ~/.vimrc_local ]; then
	touch ~/.vimrc_local
fi

if [ ! -d ~/.vim/spell ]; then
	ln -s -v "$DIR"/.vim/spell ~/.vim/

	find ~/.vim/spell/ -name '*.add' | \
		xargs -I{} vim +":mkspell! {}|q" -
fi

mkdir -p ~/.vim/{autoload,ftplugin,colors}

for f in "$DIR"/.vim/ftplugin/*; do
	ln -s -v -f "$f" ~/.vim/ftplugin/
done

for f in "$DIR"/.vim/colors/*; do
	ln -s -v -f "$f" ~/.vim/colors/
done

curl --silent https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim -o ~/.vim/autoload/pathogen.vim

# vim-plug BEGIN
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim '+:PlugInstall|qa'
# vim-plug END

