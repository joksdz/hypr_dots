#!/bin/bash
# updates
pacman -Syu

cd .
current=$(pwd)

read -p "Enter your username: " user
# check for ~/.config
if  [ -e "/home/$user/.config" ]; then
  
  conf_f="/home/$user/.config"
  cd $conf_f
  
#installing yay
  sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
# installing main packeges  
yay -S swaylock kitty waybar wofi wlogout neovim thunar fish pulseaudio pipewire alsamixer nmtui speedtest-cli anime-cli mpv btop swww ffmpeg hyprshot sddm blueman firefox nwg-look qt6 qt6-svg bc ttf-roboto-mono ttf-nerd-fonts-symbols-mono ttf-roboto-mono-nerd


# setup for sddm 
git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
rm -rf /usr/share/sddm/themes/sddm-astronaut-theme
cp -r /home/$user/.config/

echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf
# copying files and makes them into an arry  
ls > files.txt
  files=($(cat files.txt))
# checks if directory already exists in ~/.config
  for i in "${files[@]}"; do
	if [  "$i" == "hypr" ] || [ "$i" == "nvim" ]|| [ "$i" == "swaylock" ] || [ "$i" == "waybar" ] || [ "$i" == "wofi" ] || [ "$i" == "kitty" ] || [ "$i" == "wlogout" ]  ; then
		# removes the directory
		rm -rf $i
	fi
	# copys the filles from the repo to the ~/.config
rm -rf LICENSE README.md
find $current \
    ! -name 'README.md' \
    ! -name 'LISENSE.txt' \
    ! -name 'install.sh' \
    -exec cp --parents {} /home/$user/.config \;

cp -r $current/* /home/$user/.config

	done

# if /.config doesn't make one and do the rest  
else
  
	mkdir /home/$user/.config
fi
