#!/bin/bash

clear
trap 'cleanup' exit
echo -n $border
tput cup $lines 0
echo -n $border
tput cup $(((lines/2) - 3)) 0

write_centered "- To move, both through menu and in game use WSAD -"
write_centered "- To select an option press X -"
write_centered "- To go back to menu, use Q -"
write_centered ""
write_centered "Miłek, 2023"

tput civis
read -rsn1
source ./title_page.sh
