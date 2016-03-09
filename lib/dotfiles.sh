#!/bin/bash
# This installs derhuerst/dotfiles



if ask 'Install derhuerst/dotfiles?'; then
	curl -sSL https://raw.githubusercontent.com/derhuerst/dotfiles/master/install | bash
fi
