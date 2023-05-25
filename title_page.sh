#!/bin/bash

draw_jorek() {
    #43 szerokosc 7 wysokosc
tput cup 5 21
    echo -e "      ██╗  █╗ █╗                           "
tput cup 6 21
    echo -e "      ██║  ╚╝ ╚╝  ██████╗ ███████╗██╗  ██╗ "
tput cup 7 21
    echo -e "      ██║ ██████╗ ██╔══██╗██╔════╝██║ ██╔╝ "
tput cup 8 21
    echo -e "      ██║██╔═══██╗██████╔╝█████╗  █████╔╝  "
tput cup 9 21
    echo -e " ██   ██║██║   ██║██╔══██╗██╔══╝  ██╔═██╗  "
tput cup 10 21
    echo -e " ╚█████╔╝╚██████╔╝██║  ██║███████╗██║  ██╗ "
tput cup 11 21
    echo -e "  ╚════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ "
}
clear
lines=24
cols=80
avr_col=40
avr_row=12
tput cup 0 0
    echo "#"
tput cup $lines 0
    echo "#"
tput cup 0 $cols
    echo "#"
tput cup $lines $cols
    echo "#"
draw_jorek
echo $lines
echo $cols    
sleep 30    