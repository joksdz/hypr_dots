#!/bin/bash
path="/home/mario/Downloads/wallpapers/"
pos_path="/home/mario/testtest/Pos_num_gen.sh"
p=$(bash $pos_path) #random position number
trans_types=("wipe" "grow" "center" "outer" "left" "right") #transition types from the swww doc
ls $path > walls.txt #list of wallpapers
walls=($(cat walls.txt)) #array of wallpapers
random=$((RANDOM % ${#walls[@]})) #random number
random2=$((RANDOM % ${#trans_types[@]}))

if [[ ${trans_types[$random2]} == "grow" || ${trans_types[$random2]} == "outer" ]]; then #check if the transition type is grow or outer
	swww img $path${walls[$random]} --transition-type ${trans_types[$random2]} --transition-pos $p,$p # gives it a random position 

else 
	swww img $path${walls[$random]} --transition-type ${trans_types[$random2]} # uses diffrent transition types exept grow and outer

fi
                                                               
                                                               
#TTTTTTTTTTTTTTTTTTTTTTT       GGGGGGGGGGGGGKKKKKKKKK    KKKKKKK
#T:::::::::::::::::::::T    GGG::::::::::::GK:::::::K    K:::::K
#T:::::::::::::::::::::T  GG:::::::::::::::GK:::::::K    K:::::K
#T:::::TT:::::::TT:::::T G:::::GGGGGGGG::::GK:::::::K   K::::::K
#TTTTTT  T:::::T  TTTTTTG:::::G       GGGGGGKK::::::K  K:::::KKK
#        T:::::T       G:::::G                K:::::K K:::::K   
#       T:::::T       G:::::G                K::::::K:::::K    
#       T:::::T       G:::::G    GGGGGGGGGG  K:::::::::::K     
#       T:::::T       G:::::G    G::::::::G  K:::::::::::K     
#       T:::::T       G:::::G    GGGGG::::G  K::::::K:::::K    
#       T:::::T       G:::::G        G::::G  K:::::K K:::::K   
#       T:::::T        G:::::G       G::::GKK::::::K  K:::::KKK
#     TT:::::::TT       G:::::GGGGGGGG::::GK:::::::K   K::::::K
#     T:::::::::T        GG:::::::::::::::GK:::::::K    K:::::K
#     T:::::::::T          GGG::::::GGG:::GK:::::::K    K:::::K
#     TTTTTTTTTTT             GGGGGG   GGGGKKKKKKKKK    KKKKKKK
                                                               
                                                               
                                                               
                                                               
                                                               
                                                               
                                                               


