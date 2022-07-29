#!/bin/sh
feh --bg-fill "$HOME/Pictures/Backgrounds/bg_ibm.jpg" &
xrandr --rate 144.00 &
picom &
dwmblocks &
xrdb -merge ~/.Xresources
dwm
