#!/bin/bash
# This script removes OS X bloat.



shopt -s extglob



printf "Some customizations require root priveledges. Please enter your password.\n"
sudo -v
printf "Thanks.\n\n"



diskUsage=$(df -m / | tail -n 1 | awk '{print $3}')



if ask 'Delete all Dashboard widgets?'; then
	sudo rm -rf /Library/Widgets/*
	sudo rm -rf /Sytem/Library/WidgetResources/*
fi

if ask 'Open Font Book to delete big fonts?'; then
	open /Applications/Font\ Book.app
fi

if ask 'Delete all default wallpapers?'; then
	sudo rm -rf /Library/Desktop\ Pictures/*
	if ask 'Download an awesome moon wallpaper by Bob Familiar?'; then
		sudo curl -sS https://farm7.staticflickr.com/6034/6245070828_72e2ca2f64_o_d.jpg -o /Library/Desktop\ Pictures/bob-familiar-moon.jpg &
	fi
fi

for dictionary in /Library/Dictionaries/*; do
	if ask "Delete $(basename "$dictionary")?"; then
		sudo rm -rf $dictionary
	fi
done

if ask 'Open Finder to delete printer drivers?'; then
	open /Library/Printers
fi

if ask 'Delete Grapher example documents?'; then
	sudo rm -rf /Library/Application\ Support/Apple/Grapher
	if ask 'Delete Grapher.app?'; then
		sudo rm -rf '/Applications/Grapher.app'
	fi
fi

if ask 'Delete Game Center.app?'; then
	sudo rm -rf '/Applications/Game Center.app'
fi

if ask 'Delete Stickies.app?'; then
	sudo rm -rf '/Applications/Stickies.app'
fi

if ask 'Delete Chess.app?'; then
	sudo rm -rf /Applications/Chess.app
fi

if ask 'Delete iBooks.app?'; then
	sudo rm -rf /Applications/iBooks.app
fi

if ask 'Delete Audio Midi Setup.app?'; then
	sudo rm -rf '/Applications/Utilities/Audio Midi Setup.app'
fi

if ask 'Delete Boot Camp Assistant.app?'; then
	sudo rm -rf '/Applications/Utilities/Boot Camp Assistant.app'
fi

if ask 'Delete Migration Assistant.app?'; then
	sudo rm -rf '/Applications/Utilities/Migration Assistant.app'
fi

if ask 'Delete Photo Library Migration Utility.app?'; then
	sudo rm -rf '/System/Library/CoreServices/Photo Library Migration Utility.app'
fi

if ask 'Delete every voice except Alex?'; then
	sudo rm -rf /System/Library/Speech/Voices/!(Alex.speechVoice)
	if ask 'Delete Alex as well?'; then
		sudo rm -rf /System/Library/Speech/Voices/Alex.speechVoice
	fi
fi

if ask 'Delete emacs from BSD?'; then
	sudo rm -rf /usr/bin/emacs
	sudo rm -rf /usr/bin/emacs-undumped
	sudo rm -rf /usr/bin/emacsclient
	sudo rm -rf /usr/libexec/emacs/
	sudo rm -rf /usr/libexec/dumpemacs
	sudo rm -rf /usr/share/emacs/
	sudo rm -rf /usr/share/info/emacs
	sudo rm -rf /usr/share/info/emacs-1
	sudo rm -rf /usr/share/info/emacs-2
	sudo rm -rf /usr/share/info/emacs-3
	sudo rm -rf /usr/share/info/emacs-4
	sudo rm -rf /usr/share/info/emacs-5
	sudo rm -rf /usr/share/info/emacs-6
	sudo rm -rf /usr/share/info/emacs-7
	sudo rm -rf /usr/share/info/emacs-8
	sudo rm -rf /usr/share/info/emacs-mime
	sudo rm -rf /usr/share/man/man1/emacs-undumped.1
	sudo rm -rf /usr/share/man/man1/emacs.1
	sudo rm -rf /usr/share/man/man1/emacsclient.1
	sudo rm -rf /usr/share/man/man8/dumpemacs.8
fi

if ask 'Delete tokenizer from BSD (for Japanese and Chinese)?'; then
	sudo rm -rf /usr/share/tokenizer/*
fi

if ask 'Delete mecabra from BSD (for Chinese and Korean)?'; then
	sudo rm -rf /usr/share/mecabra/*
	sudo rm -rf /usr/lib/libmecabra.dylib
fi

if ask 'Delete Ainu input method (for Japanese)?'; then
	sudo rm -rf /System/Library/Input\ Methods/AinuIM.app
fi

if ask 'Delete Hindi input method?'; then
	sudo rm -rf /System/Library/Input\ Methods/HindiIM.app
fi

if ask 'Delete Japanese input method?'; then
	sudo rm -rf /System/Library/Input\ Methods/JapaneseIM.app
fi

if ask 'Delete Korean input method?'; then
	sudo rm -rf /System/Library/Input\ Methods/KoreanIM.app
fi

if ask 'Delete Tamil input method?'; then
	sudo rm -rf /System/Library/Input\ Methods/TamilIM.app
fi

if ask 'Delete Vietnamese input method?'; then
	sudo rm -rf /System/Library/Input\ Methods/VietnameseIM.app
fi

if ask 'Add /bin and /sbin to Spotlight?'; then
	mdimport /bin
	mdimport /sbin
fi

if ask 'Add /Library to Spotlight?'; then
	mdimport /Library
fi

if ask 'Disable hibernation?'; then
	sudo pmset -a hibernatemode 0
	sudo rm -f /Private/var/vm/sleepimage
	sudo touch /Private/var/vm/sleepimage
	sudo chflags uchg /Private/var/vm/sleepimage
fi

if ask 'Disable local Time Machine backups?'; then
	hash tmutil &> /dev/null && sudo tmutil disablelocal
fi

if ask 'Run OS X maintenance scripts?'; then
	sudo periodic daily weekly monthly
fi

if ask 'Open Monolingual now?'; then
	open /Applications/Monolingual.app
fi

if ask 'Set the hostname now?'; then
	read -p 'hostname: ' hostname
	sudo scutil --set ComputerName $hostname
	sudo scutil --set HostName $hostname
	sudo scutil --set LocalHostName $hostname
fi



# show free disk space on /
printf "freed disk space on /: $((diskUsage - $(df -m / | tail -n 1 | awk '{print $3}')))MB\n"
