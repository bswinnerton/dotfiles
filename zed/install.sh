#!/bin/sh

OS="`uname -s`"
if [ $OS = "Darwin" ]; then
    defaults write zed.Zed-Preview ApplePressAndHoldEnabled -bool false
    defaults write zed.Zed ApplePressAndHoldEnabled -bool false
fi
