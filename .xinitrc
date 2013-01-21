devmon --exec-on-drive "notify-send --icon=block-device --urgency=low \"%f has been mounted to %d\"; urxvt -cd %d" --exec-on-unmount "notify-send --icon=block-device --urgency=low \"%f has been unmounted from %d\""&

xrdb ~/.Xresources

export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS=@im='uim'
uim-toolbar-gtk-systray &

xbindkeys &
redshift -l "$LAT:$LON" -t 6000:4400 &
urxvt &
xsetroot -solid black
setxkbmap -option ctrl:nocaps -option compose:rwin de nodeadkeys &

synclient VertEdgeScroll=1
synclient LeftEdge=0
synclient RightEdge=0

awesome -c ~/.awesome/main.lua
