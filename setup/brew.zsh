#!/usr/bin/env zsh

# If brew isn't installed install it
if [ ! -e "$(which brew)" ]; then
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade


function install() {
	if [ ! -e "$(brew --prefix ${@} 2>/dev/null)"]; then
		brew install "${@}"
	fi
}

install scala
install sbt
install play
install node

# Remove outdate versions from the cellar
brew cleanup