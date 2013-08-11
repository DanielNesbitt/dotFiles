#!/usr/bin/env zsh

# Install native apps from brew cask
# This hasn't really been tested

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
brew tap phinze/homebrew-cask
brew install brew-cask

function installcask() {
	echo "Installing $(tput setaf 5)${@}$(tput sgr0)"
	brew cask install "${@}"
}

installcask the-unarchiver
installcask alfred
installcask app-cleaner
installcask intellij-ultimate
installcask istat-menus
installcask sublime-text
installcask google-chrome
installcask transmission
installcask dropbox
installcask evernote
installcask vlc

# Remove outdate versions from the cellar
brew cleanup