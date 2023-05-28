#!/bin/bash

clear

border="#"$(printf "%0.s-" $(seq 1 $((cols-2))))"#"
echo -n $border
tput cup $lines 0
echo -n $border
tput cup $(((lines/2) - 3)) 0

write_centered() {
    text=$1
    length=${#text}
    padding=$(( (cols - length) / 2 ))
    printf "%${padding}s" && echo $text
}

write_centered "- To move, both through menu and in game use WSAD -"
write_centered "- To select an option press X -"
write_centered "- To go back to menu, use Q -"
write_centered ""
write_centered "Miłek, 2023"

tput civis
read -rsn1
clear
tput cnorm
