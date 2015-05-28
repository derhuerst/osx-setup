#!/bin/bash
# This script installs developer stuff on OS X.



# install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"



# Install Bash version 4 on MacOS X
# https://gist.github.com/samnang/1759336
brew install bash
if [ $(cat /private/etc/shells | grep '/usr/local/bin/bash' | wc -l) -eq 0 ]; then
	sudo bash -c 'echo /usr/local/bin/bash >> /private/etc/shells'
fi


brew install \
	git \
	hub \
	node \
	unrar \
	wget \
	zsh \
	zsh-completions \
	ssh-copy-id \
	megacmd
brew tap bfontaine/aliases



npm install -g \
	coffee-script \
	http-server \
	spot \
	svgo



brew install caskroom/cask/brew-cask
brew cask install \
	skype \
	mumble \
	firefox \
	google-chrome \
	flash \
	transmission \
	transmit \
	sublime-text \
	marked \
	github \
	inkscape \
	cocoapacketanalyzer \
	keka \
	vlc \
	imageoptim \
	telegram \
	ccleaner \
	virtualbox \
	caffeine \
	monolingual \
	handbrake \
	leap-motion \
	thyme \
	disk-inventory-x



brew cask install \
	quicklook-csv \
	quicklook-json \
	qlmarkdown \
	qlstephen \
	qlcolorcode \
	suspicious-package



external=( \
	'/Volumes/Medien/Software/Programme/Marked 2/marked.app.zip' \
	'/Volumes/Medien/Software/Programme/Moom/moom.app.zip' \
	'/Volumes/Medien/Software/Programme/Flick/flick.app.zip' \
	'/Volumes/Medien/Software/Programme/handyPrint/handyPrint.app.zip' \
	'/Volumes/Medien/Software/Programme/iA Writer/ia-writer.app.zip' \
	'/Volumes/Medien/Software/Programme/Logitech Camera Settings/logitech-camera-settings.app.zip' \
	'/Volumes/Medien/Software/Programme/Dash/dash.app.zip' \
	'/Volumes/Medien/Software/Programme/Moom/moom.app.zip' \
	'/Volumes/Medien/Software/Programme/Sketch/sketch.app.zip' \
	'/Volumes/Medien/Software/Programme/LanScan/lanscan.app.zip' \
	'/Volumes/Medien/Software/Programme/Sublime Text/sublime-text.app.zip' \
	'/Volumes/Medien/Software/Programme/svgo/svgo.app.zip' \
	'/Volumes/Medien/Software/Programme/Telephone/telephone.app.zip' \
	'/Volumes/Medien/Software/Programme/Wire/wire.app.zip'
)
for app in "${external[@]}"; do
	unzip -nq "$app" -d ./test
done

ln -s /System/Library/CoreServices/Applications/Screen\ Sharing.app /Applications/Screen\ Sharing.app



qlmanage -r
qlmanage -r cache
brew cleanup
npm cache -g clean
brew cask cleanup
