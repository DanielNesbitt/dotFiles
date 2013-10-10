#!/usr/bin/env zsh

# If brew isn't installed install it
if [ ! -e "$(which brew)" ]; then
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

brew install scala
brew install sbt
brew install play
brew install node

# Remove outdate versions from the cellar
brew cleanup
