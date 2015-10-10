#!/bin/bash

# Inspired by: http://mths.be/osx

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set sidebar icon size to small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Use a modified version of the Pro theme by default in Terminal.app
#open "$HOME/.dotfiles/osx/bswinnerton.terminal"
#sleep 1 # Wait a bit to make sure the theme is loaded
#defaults write com.apple.Terminal "Default Window Settings" -string "bswinnerton"
#defaults write com.apple.Terminal "Startup Window Settings" -string "bswinnerton"

###############################################################################
# Sublime text                                                                #
###############################################################################

defaults write com.sublimetext.2 ApplePressAndHoldEnabled -bool false
