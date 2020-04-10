install:
	./app-setup.sh
	./vim-setup.sh

kpax-gmail-smtp:
	# 1. Get an “app password” password from the Security section in Google Account[1].
	# 2. Configure Postfix to use it[2].
	#
	# [1]: https://myaccount.google.com/security
	# [2]: https://www.linode.com/docs/email/postfix/postfix-smtp-debian7/#configuring-smtp-usernames-and-passwords
