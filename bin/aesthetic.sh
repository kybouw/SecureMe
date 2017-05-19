#!/bin/bash

# This script as well as the gain.wav and termback.jpg resources
#		were created by saminjapan. Check out his project: https://github.com/saminjapan/CyberPatriot.git
# Modified by kybouw

#**Sets gedit, terminal, and cyberpatriot sound prefernces**#
#**Dependant on aestheticResources file within same dir**#
#ScrLoc=$(readlink -f "$0" | xargs dirname)
#Terminal
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_image" --type string "../resources/termback.jpg"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_type" --type string "image"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/bold_color_same_as_fg" --type string "true"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type string "false"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/alternate_screen_scroll" --type string "true"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/visible_name" --type string "CIA Mainframe"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/bold_color" --type string "#7373D2D11615"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "black"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "#00FF00"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_darkness" --type string "1"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type string "false"
	gconftool-2 --set "/apps/gnome-terminal/profiles/Default/title" --type string "CIA Mainframe"


#Cyber Sounds
	sudo cp ../resources/gain.wav /opt/CyberPatriot/

#Gedit
	#Display/look
	gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
	gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
	gsettings set org.gnome.gedit.preferences.editor wrap-mode 'word'
	gsettings set org.gnome.gedit.preferences.print print-wrap-mode 'word'
	gsettings set org.gnome.gedit.preferences.editor bracket-matching true
	gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
	#Saving
	gsettings set org.gnome.gedit.preferences.editor create-backup-copy true
	gsettings set org.gnome.gedit.preferences.editor auto-save true
	gsettings set org.gnome.gedit.preferences.editor auto-save-interval 1
