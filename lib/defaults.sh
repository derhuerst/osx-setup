#!/bin/bash
# This script sets a lot of `defaults`. It
# - deactivates all sorts of animations
# - shows hidden files
# - optimizes the Finder
# - improves on the Dock



printf "Some customizations require root priveledges. Please enter your password.\n"
sudo -v
printf "Thanks.\n\n"



if ask 'Disable startup sound?'; then
	sudo nvram SystemAudioVolume=" "
fi

if ask 'Increase window resize speed for Cocoa applications?'; then
	defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
fi

if ask 'Do not restore windows after ⌘ + Q?'; then
	defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
fi

if ask 'Disable menu bar transparency?'; then
	defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false
fi

if ask 'Expand save panel by default?'; then
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
fi

if ask 'Expand print panel by default?'; then
	defaults write NSGlobalDomain NSNavPanelExpandedStateForPrint -bool true
fi

if ask 'Disable the warning when changing file extensions?'; then
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
fi



# System

if ask 'Show all processes in Activity Monitor?'; then
	defaults write com.apple.ActivityMonitor ShowCategory -int 0
fi

if ask 'Stop asking to use new hard drives as Time Machine volume?'; then
	defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
fi

if ask 'Show ~/Library in Finder?'; then
	chflags nohidden ~/Library
fi

if ask 'Show /bin, /sbin and /usr in Finder?'; then
	sudo chflags nohidden /bin
	sudo chflags nohidden /sbin
	sudo chflags nohidden /usr
fi

if ask 'Only use UTF-8 in Terminal.app?'; then
	defaults write com.apple.terminal StringEncodings -array 4
fi

if ask 'Disable guest account?'; then
	sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO
fi



# Spotlight

if ask 'Hide useless things in Spotlight?'; then
	defaults write com.apple.spotlight orderedItems -array \
		'{"enabled" = 1;"name" = "APPLICATIONS";}' \
		'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
		'{"enabled" = 1;"name" = "DIRECTORIES";}' \
		'{"enabled" = 1;"name" = "PDF";}' \
		'{"enabled" = 1;"name" = "DOCUMENTS";}' \
		'{"enabled" = 1;"name" = "MESSAGES";}' \
		'{"enabled" = 1;"name" = "CONTACT";}' \
		'{"enabled" = 1;"name" = "EVENT_TODO";}' \
		'{"enabled" = 1;"name" = "IMAGES";}' \
		'{"enabled" = 1;"name" = "MUSIC";}' \
		'{"enabled" = 1;"name" = "MOVIES";}' \
		'{"enabled" = 1;"name" = "PRESENTATIONS";}' \
		'{"enabled" = 1;"name" = "SPREADSHEETS";}' \
		'{"enabled" = 1;"name" = "SOURCE";}' \
		'{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
		'{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
		'{"enabled" = 0;"name" = "FONTS";}' \
		'{"enabled" = 0;"name" = "BOOKMARKS";}' \
		'{"enabled" = 0;"name" = "MENU_OTHER";}' \
		'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
		'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
		'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
fi



# Dock

if ask 'Enable spring loading for all Dock items?'; then
	defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
fi

if ask 'Show indicator lights for open applications in the Dock?'; then
	defaults write com.apple.dock show-process-indicators -bool true
fi

if ask 'Set the icon size of Dock items to 40 pixels?'; then
	defaults write com.apple.dock tilesize -int 40
fi

if ask 'Automatically hide and show the Dock?'; then
	defaults write com.apple.dock autohide -bool true
	if ask 'Show & hide Dock instantly?'; then
		defaults write com.apple.dock autohide-time-modifier -float 0
	fi
	if ask 'Autohide Dock without delay?'; then
		defaults write com.apple.dock autohide-delay -float 0
	fi
fi

if ask 'Change minimize/maximize window effect to scaling?'; then
	defaults write com.apple.dock mineffect -string 'scale'
fi

if ask 'Clear Dock & put useful apps inside?'; then
	writeDockItems() {
		defaults write com.apple.dock persistent-apps -array
		curl -OsS https://raw.githubusercontent.com/kcrawford/dockutil/7e7b56dae7a118c256748c2f69c82b912d64c6e2/scripts/dockutil
		chmod +x ./dockutil

		apps=$1
		for app in "${apps[@]}"; do
			echo $app
			if [ "$app" = "spacer" ]; then
				defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
				continue
			fi
			app="/Applications/$app"
			if [ -e "$app" ]; then
				./dockutil --add "$app" --position end
			fi
		done

		rm ./dockutil
	}

	apps=('' \
		'System Preferences.app' \
		'spacer' \
		'Mail.app' \
		'Notes.app' \
		'Telegram.app' \
		'Telephone.app' \
		'Slack.app' \
		'Skype.app' \
		'spacer' \
		'Firefox.app' \
		'Safari.app' \
		'Google Chrome.app' \
		'spacer' \
		'Sublime Text.app' \
		'Utilities/Terminal.app' \
		'Marked 2.app' \
		'iA Writer.app' \
		'Transmit.app' \
		'spacer'
	)
	writeDockItems $apps
fi



# Mission Control

if ask 'Show & hide Mission Control instantly.'; then
	defaults write com.apple.dock expose-animation-duration -float 0.1
fi

if ask 'Stop rearranging Spaces based on recent use?'; then
	defaults write com.apple.dock mru-spaces -bool false
fi



# Keyboard & Mouse

if ask 'Set a very fast keyboard repeat rate?'; then
	defaults write NSGlobalDomain KeyRepeat -int 1
fi

if ask 'Set a short Delay until key repeat?'; then
	defaults write NSGlobalDomain InitialKeyRepeat -int 12
fi

if ask 'Enable full keyboard access for all controls?'; then
	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
fi

if ask 'Automatically illuminate keyboard in low light?'; then
	defaults write com.apple.BezelServices kDim -bool true
fi

if ask 'Turn off keyboard illumination when inactive for 2 minutes?'; then
	defaults write com.apple.BezelServices kDimTime -int 120
fi

if ask 'Trackpad: Enable tap to click?'; then
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
fi

if ask 'Trackpad: Two-finger tap for right click?'; then
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
	defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
fi

if ask 'Enable dragging with three fingers?'; then
	defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
fi



# Safari

if ask 'Safari: Show the full URL in the address bar?'; then
	defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
fi

if ask 'Safari: Stop sending search queries to Apple?'; then
	defaults write com.apple.Safari UniversalSearchEnabled -bool false
	defaults write com.apple.Safari SuppressSearchSuggestions -bool true
fi

if ask 'Set Safari’s home page to `about:blank`?'; then
	defaults write com.apple.Safari HomePage -string 'about:blank'
fi

if ask 'Enable Safari’s debug menu?'; then
	defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
fi

if ask 'Wipe Safari’s bookmarks bar?'; then
	defaults write com.apple.Safari ProxiesInBookmarksBar '()'
fi



# Finder

if ask 'Open a new window when a volume is mounted?'; then
	defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
	defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
fi

if ask 'Display full path as window title?'; then
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
fi

if ask 'Show the status bar?'; then
	defaults write com.apple.finder ShowStatusBar -bool true
fi

if ask 'Open new windows with ~/Downloads?'; then
	defaults write com.apple.finder NewWindowTarget -string 'PfLo'
	defaults write com.apple.finder NewWindowTargetPath -string 'file://${HOME}/Downloads/'
fi

if ask 'Use current directory as default search scope?'; then
	defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'
fi

if ask 'Allow text selection in Quick Look?'; then
	defaults write com.apple.finder QLEnableTextSelection -bool true
fi

if ask 'Enable spring loading for directories?'; then
	defaults write NSGlobalDomain com.apple.springing.enabled -bool true
fi

if ask 'Remove the spring loading delay for directories?'; then
	defaults write NSGlobalDomain com.apple.springing.delay -float 0
fi

if ask 'Show hidden files?'; then
	defaults write com.apple.finder AppleShowAllFiles -bool true
fi

if ask 'Show all filename extensions?'; then
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true
fi

if ask 'Make column view the default?'; then
	defaults write com.apple.finder FXPreferredViewStyle -string 'clmv'
fi



# Miscellaneous

if ask 'Disable the warning before emptying the Trash?'; then
	defaults write com.apple.finder WarnOnEmptyTrash -bool false
fi

if ask 'Automatically quit printer app once the print jobs complete?'; then
	defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true
fi

if ask 'Avoid creating .DS_Store files on network volumes.'; then
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
fi

if ask 'Change screenshot location?'; then
	defaults write com.apple.screencapture location ~/Downloads/
fi

if ask 'Save screenshots in PNG format?'; then
	defaults write com.apple.screencapture type -string 'png'
fi

if ask 'Save to disk (not to iCloud) by default?'; then
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
fi

if ask 'Disable send and reply animations in Mail.app?'; then
	defaults write com.apple.mail DisableReplyAnimations -bool true
	defaults write com.apple.mail DisableSendAnimations -bool true
fi

if ask 'Enable snap-to-grid for desktop icons?'; then
	/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy grid' ~/Library/Preferences/com.apple.finder.plist
fi

if ask 'Use plain text by default in TextEdit.app?'; then
	defaults write com.apple.TextEdit RichText -int 0
	defaults write com.apple.TextEdit PlainTextEncoding -int 4
	defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
fi

if ask 'Disable menu bar transparency?'; then
	defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false
fi



printf "Save all your work now! Continue by hitting return."
read -p ''

for app in 'Activity Monitor' 'Address Book' 'Calendar' 'Contacts' 'cfprefsd' \
'Dock' 'Finder' 'Mail' 'Messages' 'Safari' 'SizeUp' 'SystemUIServer' \
'Terminal' 'Transmission' 'Twitter' 'iCal'; do
	killall $app > /dev/null 2>&1
done

printf "Done, you should restart now. Have fun! 🍺\n"
