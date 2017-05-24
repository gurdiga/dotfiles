#!/bin/bash

set -e

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install --with-pcre git;

brew tap homebrew/dupes
brew tap homebrew/versions
brew install node rlwrap curl wget htop unrar watch vim imagemagick rsync gifsicle asciinema ffmpeg pgrep axel mtr app-engine-go-64 tmate tree jsonpp jq ctags Caskroom/cask/keycastr
brew install coreutils grep gnu-sed findutils --with-default-names
brew install fzf && /usr/local/opt/fzf/install

brew install bash
sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash

brew install nginx
git clone git@github.com:suzanshakya/nginx-server.git ~/src/nginx-server

npm install -g elm-format
