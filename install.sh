#!/bin/bash
pacman -Syu


current=$(pwd)

read -p "Enter your username: " user

if  [ -e "/home/$user/.config" ]; then
  
  conf_f="/home/$user/.config"
  cd $conf_f
  

  sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
 
yay -S swaylock kitty waybar wofi wlogout neovim thunar fish pulseaudio pipewire alsamixer nmtui speedtest-cli anime-cli mpv btop swww ffmpeg hyprshot sddm blueman firefox nwg-look qt6

  ls > files.txt
  files=($(cat files.txt))

  for i in "${files[@]}"; do
	if [  "$i" == "hypr" ] || [ "$i" == "nvim" ]|| [ "$i" == "swaylock" ] || [ "$i" == "waybar" ] || [ "$i" == "wofi" ] || [ "$i" == "kitty" ] || [ "$i" == "wlogout" ]  ; then
		echo "exits"
	fi
	done

else
  
	mkdir /home/$user/.config
fi
