#!bin/sh










##quit:
killall waybar



##reload:
if [[ $USER= "mario"]]
then
    waybar -c ~/.config/waybar/conf & -s ~/.config/waybar/style.ss
else 
   waybar &
   fi
