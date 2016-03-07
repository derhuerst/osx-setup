#!/bin/bash
# This script installs developer stuff on OS X.



# install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"



brew install \
	git \
	hub \
	git-flow \
	node \
	unrar \
	wget \
	fzf \
	speedtest_cli \
	zsh \
	zsh-completions \
	ssh-copy-id \
	tree
brew tap bfontaine/aliases



npm install -g \
	coffee-script \
	gulp \
	http-server \
	http-console \
	spot \
	forever \
	node-inspector \
	localtunnel



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
	disk-inventory-x



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
