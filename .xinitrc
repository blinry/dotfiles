xrdb ~/.Xresources

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
#export GLFW_IM_MODULE=ibus # Required for kitty.

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_SCALE_FACTOR=1.5

init-touchpad

exec i3
