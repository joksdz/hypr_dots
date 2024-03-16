#!/bin/bash
path="/home/mario/Downloads/wallpapers/"
ls $path > walls.txt
walls=($(cat walls.txt))
random=$((RANDOM % ${#walls[@]})) #random number
swww img $path${walls[$random]}
