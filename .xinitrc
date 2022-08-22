xrdb ~/.xresources

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_SCALE_FACTOR=1.5

# Use the whole area of the touchpad for scrolling.
synclient VertEdgeScroll=1
synclient LeftEdge=0
synclient RightEdge=0
synclient VertScrollDelta=20
synclient HorizScrollDelta=20
synclient CoatingSpeed=0
synclient VertHysteresis=0
synclient HorizHysteresis=0
synclient FingerLow=1
synclient FingerHigh=5

exec i3
