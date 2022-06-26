# enable scrolling with trackpoint and middle button
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5

feh --bg-fill ~/Pictures/bg/bg.png &

XRES="$HOME/.Xresources"
if [ -f $XRES ]; then
	xrdb -merge XRES &
fi

xrdb -load $XRES &
dwmblocks &
exec dwm
