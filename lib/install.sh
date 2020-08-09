#!/bin/bash
# This script installs developer stuff on OS X.



xcode-select --install

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew tap dandavison/delta https://github.com/dandavison/delta
brew install \
	asciinema \
	bat \
	coreutils \
	curl \
	dwdiff \
	ffmpeg \
	findutils \
	fish \
	fzf \
	git \
	dandavison/delta/git-delta \
	gnu-time \
	gnupg \
	grep \
	htop \
	hub \
	iperf3 \
	jq \
	miniupnpc \
	mitmproxy \
	moreutils \
	mosh \
	node \
	pstree \
	pv \
	qrencode \
	redis \
	rename \
	ripgrep \
	speedtest-cli \
	ssh-copy-id \
	starship \
	terminal-notifier \
	tree \
	watch \
	wget \
	xsv \
	youtube-dl

if [ $(cat /private/etc/shells | grep $(which fish) | wc -l) -eq 0 ]; then
	sudo bash -c "echo $(which fish) >> /private/etc/shells"
fi


npm install -g \
	serve \
	spot \
	localtunnel \
	npm-name-cli \
	spoof \
	coup-letmein \
	coup-lights \
	pkgfiles \
	time-tracking \
	url-decode-encode-cli \
	dependency-check \
	travis-watch



brew install caskroom/cask/brew-cask
brew cask install \
	skype \
	firefox \
	flash \
	transmission \
	transmit \
	github \
	cocoapacketanalyzer \
	keka \
	vlc \
	imageoptim \
	telegram \
	ccleaner \
	monolingual \
	disk-inventory-x \
	conductor



brew cask install \
	quicklook-csv \
	quicklook-json \
	qlmarkdown \
	qlstephen \
	qlcolorcode \
	suspicious-package

qlmanage -r
qlmanage -r cache



external=( \
	'/Volumes/Medien/Software/Programme/Marked 2/marked.app.zip' \
	'/Volumes/Medien/Software/Programme/Moom/moom.app.zip' \
	'/Volumes/Medien/Software/Programme/Flick/flick.app.zip' \
	'/Volumes/Medien/Software/Programme/iA Writer/ia-writer.app.zip' \
	'/Volumes/Medien/Software/Programme/Dash/dash.app.zip' \
	'/Volumes/Medien/Software/Programme/Sketch/sketch.app.zip' \
	'/Volumes/Medien/Software/Programme/LanScan/lanscan.app.zip' \
	'/Volumes/Medien/Software/Programme/Sublime Text/sublime-text.app.zip' \
	'/Volumes/Medien/Software/Programme/Telephone/telephone.app.zip'
)
for app in "${external[@]}"; do
	unzip -nq "$app" -d ./test
done

ln -s /System/Library/CoreServices/Applications/Screen\ Sharing.app /Applications/Screen\ Sharing.app

brew cleanup
brew cask cleanup
npm cache -g clean



curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fisher add franciscolourenco/done
