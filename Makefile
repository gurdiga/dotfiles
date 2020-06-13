install:
	./app-setup.sh
	./vim-setup.sh

vscode-get:
	@cp -v ~/Library/Application\ Support/Code/User/settings.json vscode/settings.json
	cp -v ~/Library/Application\ Support/Code/User/keybindings.json vscode/keybindings.json

vscode-apply:
	@cp --backup=numbered -v vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
	cp --backup=numbered -v vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

kpax-gmail-smtp:
	# 1. Get an “app password” password from the Security section in Google Account[1].
	# 2. Configure Postfix to use it[2].
	#
	# [1]: https://myaccount.google.com/security
	# [2]: https://www.linode.com/docs/email/postfix/postfix-smtp-debian7/#configuring-smtp-usernames-and-passwords
