#!/bin/zsh

# Find out where we're running from
DIR=`dirname $0:A`

# Install zsh
ln -s $DIR/zsh/oh-my-zsh $HOME/.oh-my-zsh
ln -s $DIR/zsh/zshrc $HOME/.zshrc

# Install Sublime 2 user settings
if [[ $OSTYPE == darwin* ]]; then
	ln -s $DIR/sublime2 "$HOME/Library/Application Support/Sublime Text 2/Packages/User"
fi
