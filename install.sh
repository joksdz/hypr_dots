#!/bin/bash
echo 'this script will delete a lot of your files on your .config directory, are you sure you want to do this ?'
read -p "y/n" -n 1 -r input 
echo    #  move to a new line
if [[ $input = "y" ]]; then
# updates
pacman -Syu

cd .
current=$(pwd)

install() {
	 conf_f="$HOME/.config"
  cd $conf_f
  
#installing yay
  sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
# installing main packeges  
yay -S swaylock kitty waybar wofi wlogout neovim thunar fish pulseaudio pipewire alsamixer nmtui speedtest-cli anime-cli mpv btop swww ffmpeg hyprshot sddm blueman firefox nwg-look qt6 qt6-svg bc ttf-roboto-mono ttf-nerd-fonts-symbols-mono ttf-roboto-mono-nerd


# setup for sddm 
git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
rm -rf /usr/share/sddm/themes/sddm-astronaut-theme
cp -r $current/theme_sddm /usr/share/sddm/themes

echo "[Theme]
Current=theme_sddm" | sudo tee /etc/sddm.conf
# copying directories and makes them into an arry  
ls > files.txt
  files=($(cat files.txt))
# checks if directory already exists in ~/.config
  for i in "${files[@]}"; do
	if [  "$i" == "hypr" ] || [ "$i" == "nvim" ]|| [ "$i" == "swaylock" ] || [ "$i" == "waybar" ] || [ "$i" == "wofi" ] || [ "$i" == "kitty" ] || [ "$i" == "wlogout" ]  ; then
		# removes the directory
		rm -rf $i
	fi
	# copys the filles from the repo to the ~/.config
	#and exucludes some files
find $current \
    ! -name 'README.md' \
    ! -name 'LISENSE.txt' \
    ! -name 'install.sh' \
    -exec cp --parents {} $HOME/.config \;
	done


}

if  [ -e "$HOME/.config" ]; then
	install
else
	mkdir -p "$HOME/.config"
	install
fi

fi
