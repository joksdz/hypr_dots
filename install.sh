#!/bin/bash
current=$(pwd)
read -p "Enter your username: " user

if  [ -e "/home/$user/.config" ]; then
  conf_f="/home/$user/.config"
  cd $conf_f
  ls > files.txt
  if [ -e ]; then

else
  mkdir /home/$user/.config
fi
