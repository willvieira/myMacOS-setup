all:
	chmod a+x macOS_setup.sh
	chmod a+x first_install.sh
	chmod a+x verify.sh
	sh first_install.sh
	sh macOS_setup.sh
	sh verify.sh
