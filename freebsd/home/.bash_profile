#!/usr/local/bin/bash

if [[ -z "$DISPLAY" ]] && [[ $(tty) = "/dev/ttyv0" ]]; then
	startx
fi

# opam configuration
test -r /usr/home/rf/.opam/opam-init/init.sh && . /usr/home/rf/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
