#!/bin/zsh

# Find out where we're running from
DIR=`dirname $0`

# Install zsh
source $DIR/zsh/install.sh $DIR

# Install Sublime 2 user settings
if [[ $OSTYPE == darwin* ]]; then
	ln -s $DIR/sublime2 $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages/User
fi
