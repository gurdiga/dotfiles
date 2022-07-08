#!/bin/bash

echo "Installing applications..."

# See https://sipb.mit.edu/doc/safe-shell/
set -euf -o pipefail

grep -F '.bash_aliases' ~/.bashrc || \
	echo '. ~/.bash_aliases' >> ~/.bashrc

grep -F '.bashrc.my' ~/.bashrc || \
	echo '. ~/.bashrc.my' >> ~/.bashrc

grep -F '~/.bashrc' ~/.bash_profile || \
	echo '. ~/.bashrc' >> ~/.bash_profile

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -v -s "$DIR"/{.gitconfig,.gitignore,.vimrc,.bash_aliases,.bashrc.my,vimp,.mplayer,.screenrc,.irbrc,.ctags,.my.cnf} ~/

crontab < .crontab

brew install git
brew install make curl wget htop unrar watch vim imagemagick rsync gifsicle asciinema mpv ffmpeg pgrep mtr tree jq ctags moreutils sqlite-utils shellcheck
brew install coreutils grep gnu-sed findutils
brew install fd ag fzf && /usr/local/opt/fzf/install

brew install bash bash-completion

BREW_BASH=$(brew --prefix)/bin/bash
sudo sh -c "echo $BREW_BASH >> /etc/shells"
chsh -s $BREW_BASH

# for the `www` alias
brew install nginx
git clone git@github.com:suzanshakya/nginx-server.git ~/src/nginx-server

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

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

			tac | awk -F '^ *[0-9]+  ' '!x[\$2]++' | tac | # gurdiga@gmail.com: uniq history

		EOF
	fi
}

check_fzf_patch
