#!/bin/bash
# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    pulseaudio --start
    startx
	[[ -f "$HOME/.Xresources" ]] && xrdb -merge "$HOME/.Xresources"
fi
