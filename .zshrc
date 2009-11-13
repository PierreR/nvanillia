# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/pierre/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install

export GREP_OPTIONS='--exclude=\*.svn\*'
export EDITOR=vim
export BMOB_DIR=~/project/bmob
export DJANGO_SETTINGS_MODULE='settings'
export TERM=xterm-256color
export MOZILLA_CERTIFICATE_FOLDER=~/.mozilla/firefox/djt0wc2v.default
export JDK_HOME=/opt/java
# export TERM=konsole

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
setopt histverify
bindkey -e
# End of lines configured by zsh-newuser-install
alias cal='cal -3'
alias ls='ls --color=auto'
alias close_laptop='xrandr --output LVDS --off --output VGA --auto'
alias open_laptop='xrandr --output LVDS --auto --output VGA --auto --right-of LVDS'
alias __tile_simple="styler.py simple"
alias cd_django='cd $BMOB_DIR'
PROMPT='%~ %% '
alias ssh_bmob='ssh 192.168.34.51'
alias __connect_to_staging='cd_django;ssh -i private_key pmobilite@192.168.15.66'
#alias emacs='emacs --fullscreen'
alias la='ls -lah --color'
alias du='du -h'
alias __test_='./start-tests-local'
alias __shell='python manage.py shell'
alias __django='cd_django;./start-sites'
alias __reset_='python manage.py reset $1'
alias netbeans='/usr/local/netbeans-6.5/bin/netbeans --laf com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
alias __etags="cd_django;find . -type f -iname '*.py' | etags.emacs --lang=python -"
#alias __ie_6='vncviewer ci10560'
alias __reset_all='__reset_ articles works sites news projects ticker'
alias __vpn='cd ~/documents/cirb/manage/vpn;sudo openvpn --config Pierre_Radermecker.ovpn'
alias __i_='sudo pacman -S $1'
alias __u='sudo pacman -Suy'
alias __reload_zsh='source ~/.zshrc'
alias __lock_pc="xscreensaver-command -lock"
alias __print_="lpr -P Xeros $1"
alias __mount_cirb_me='mount //192.168.34.21/Pradermecker'
alias __mount_cirb_data='sudo mount //192.168.34.21/data/projects'
alias __commit="git commit -a -m 'sync'"
alias __sync="git push /mnt/cirb/me/backup"
alias df="df -h"
alias __mount_usb='sudo mount /dev/sdb /mnt/usb' 
alias emacs='emacs -nw'
cdpath+=(~/project/ ~/project/portail_bruxelles_mobilite/)
path+=(/opt/java/bin ~/bin /usr/local/bin)

