#!/bin/sh
xmodmap -e "remove lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"
