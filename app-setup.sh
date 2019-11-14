#!/bin/bash

echo "Installing applications..."

# See https://sipb.mit.edu/doc/safe-shell/
#set -euf -o pipefail

grep -F '.aliases' ~/.bashrc || \
	echo '. ~/.aliases' >> ~/.bashrc

grep -F '.bashrc.my' ~/.bashrc || \
	echo '. ~/.bashrc.my' >> ~/.bashrc

grep -F '~/.bashrc' ~/.bash_profile || \
	echo '. ~/.bashrc' >> ~/.bash_profile

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -v -s "$DIR"/{.gitconfig,.gitignore,.vimrc,.aliases,.bashrc.my,vimp,.mplayer,.screenrc,.irbrc,.ctags,.my.cnf} ~/

crontab < .crontab

if [ ! -f /usr/local/bin/brew ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install git
brew tap homebrew/dupes
brew tap homebrew/versions
brew install node rlwrap curl wget htop unrar watch vim imagemagick rsync gifsicle asciinema ffmpeg pgrep axel mtr app-engine-go-64 tmate tree jsonpp jq yq ctags Caskroom/cask/keycastr moreutils httpie
brew install coreutils grep gnu-sed findutils
brew install parallel && brew link --overwrite parallel
brew install fd ag fzf && /usr/local/opt/fzf/install

brew install bash bash-completion
sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash

# for the `www` alias
brew install nginx
git clone git@github.com:suzanshakya/nginx-server.git ~/src/nginx-server

# for the `wwws` alias
go get github.com/GoogleChrome/simplehttp2server

npm install -g elm-format

pip3 install csvtomd

function check_fzf_patch() {
	source ~/.bashrc # load fzf that was installed above
	local file=`source_location __fzf_history__ | awk '{print \$3}'`

	if [ -z file ]; then
		cat <<-EOF

		__fzf_history__ function is not defined in the current shell; will not patch.

		EOF
	elif grep -F '# gurdiga@gmail.com: uniq history' $file; then
		cat <<-EOF

		fzf is already patched. It’s all good.

		EOF
	else
		cat <<-EOF
		++ Here is the file to patch: $file. Insert this line as appropriate:

			awk -F '^ *[0-9]+  ' '!x[\$2]++' | # gurdiga@gmail.com: uniq history

		EOF
	fi
}

check_fzf_patch
