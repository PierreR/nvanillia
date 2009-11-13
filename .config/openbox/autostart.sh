
#!/bin/sh

xrdb -merge .Xresources

#display -window root /usr/share/pixmaps/backgrounds/gnome/background-default.jpg
xpmroot /usr/share/pixmaps/backgrounds/gnome/background-default.xpm &

xscreensaver &

#xsetroot -cursor_name whiteglass

