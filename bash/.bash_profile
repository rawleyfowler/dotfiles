#!/usr/local/bin/bash

if [[ -z "$DISPLAY" ]] && [[ $(tty) = "/dev/ttyv0" ]]; then
	startx
fi
