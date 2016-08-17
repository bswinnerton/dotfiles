#!/bin/bash

# Inspired by: http://mths.be/osx

if [ "$(uname -s)" == "Darwin" ]
then
  # Set sidebar icon size to small
  defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

  # Trackpad: enable tap to click for this user
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  # Enable full keyboard access for all controls
  # (e.g. enable Tab in modal dialogs)
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  # Set an insanely fast keyboard repeat rate
  defaults write NSGlobalDomain InitialKeyRepeat -int 10
  defaults write NSGlobalDomain KeyRepeat -int 1

  # Show icons for hard drives, servers, and removable media on the desktop
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

  # Use list view in all Finder windows by default
  # Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
fi
