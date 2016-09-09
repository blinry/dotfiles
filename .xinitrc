xrdb ~/.xresources

export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS='@im=uim'

urxvt &
mpd &
xsetroot -solid black

# Use the whole area of the touchpad for scrolling.
synclient VertEdgeScroll=1
synclient LeftEdge=0
synclient RightEdge=0
synclient VertScrollDelta=100
synclient HorizScrollDelta=100
synclient CoatingSpeed=0
synclient VertHysteresis=0
synclient HorizHysteresis=0
synclient FingerLow=1
synclient FingerHigh=5

export GDK_SCALE=2
export GDK_DPI_SCALE=0.666

# Hide the mouse pointer after 5 seconds of inactivity.
unclutter -idle 5 -jitter 2 -root &

init-keyboard

exec i3
