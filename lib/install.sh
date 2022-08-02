#!/bin/bash
# This script installs developer stuff on OS X.



xcode-select --install

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew tap dandavison/delta https://github.com/dandavison/delta
brew install \
	asciinema \
	bash \
	bat \
	coreutils \
	curl \
	dog \
	dwdiff \
	ffmpeg \
	findutils \
	fish \
	fzf \
	gh \
	git \
	git-delta \
	gnu-tar \
	gnu-time \
	gnupg \
	grep \
	htop \
	iperf3 \
	jq \
	miller \
	mitmproxy \
	moreutils \
	mosh \
	node \
	postgis \
	pstree \
	pv \
	qrencode \
	redis \
	rename \
	restic \
	ripgrep \
	speedtest-cli \
	ssh-copy-id \
	starship \
	terminal-notifier \
	tldr \
	tree \
	wget \
	xsv \
	yt-dlp

if [ $(cat /private/etc/shells | grep $(command -v fish) | wc -l) -eq 0 ]; then
	sudo bash -c "echo $(command -v fish) >> /private/etc/shells"
fi

npm install -g \
	serve \
	localtunnel \
	spoof \
	time-tracking \
	url-decode-encode-cli \
	parse-url-cli \
	query-string-cli \
	util-inspect-cli \
	pev2-cli \
	dependency-check



brew install caskroom/cask/brew-cask
brew cask install \
	firefox \
	transmission \
	github \
	cocoapacketanalyzer \
	keka \
	vlc \
	imageoptim \
	sublime-text \
	telegram



brew cask install \
	quicklook-csv \
	quicklook-json \
	qlmarkdown \
	qlstephen \
	qlcolorcode

qlmanage -r
qlmanage -r cache



brew cleanup
