#!/bin/bash
# This is a general-purpose function to ask Yes/No questions in Bash. It keeps repeating the question until it gets a valid answer.
# https://gist.github.com/davejamesmiller/1965569



ask() {
	while true; do
		read -n 1 -p "$1 [y/n] > " REPLY
		case "$REPLY" in
			Y*|y*)
				printf "\n"
				return 0
				;;
			N*|n*)
				printf "\n"
				return 1
				;;
		esac
	done
}