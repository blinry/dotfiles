xrdb ~/.xresources

export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS=@im='uim'
uim-toolbar-gtk-systray &

redshift -l "$LAT:$LON" -t 6000:4400 &
urxvt &
mpd &
xsetroot -solid black

# Use the whole area of the touchpad for scrolling.
synclient VertEdgeScroll=1
synclient LeftEdge=0
synclient RightEdge=0

# Hide the mouse pointer after 5 seconds of inactivity.
unclutter -idle 5 -jitter 2 -root &

xset m 3 0 # move mouse 3 times as fast as normal, use "natural formula" for acceleration
init-keyboard

exec herbstluftwm -c ~/.herbstluftwm/autostart
