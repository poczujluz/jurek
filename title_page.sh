#!/bin/bash

NC='\033[0m' #no color
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1;34m'
clear
trap 'cleanup' exit
lines=$LINES
cols=$COLUMNS
avr_col=$((cols/2))
avr_row=$((lines/2))
stty -echo
border="#"$(printf "%0.s-" $(seq 1 $((cols-2))))"#"

write_centered() {
    text=$1
    length=${#text}
    padding=$(( (cols - length) / 2 ))
    printf "%${padding}s" && echo -en $text
}

cleanup() {
    clear
    stty echo
}

draw_jorek() {
    word_title_line=$((avr_row-7))
    jorek_column=$((avr_col-22))
    #43 szerokosc 7 wysokosc
tput cup $word_title_line  $jorek_column
((word_title_line++))
    echo -e "      ${PURPLE}██${NC}╗  ${PURPLE}█${NC}╗ ${PURPLE}█${NC}╗                           "
tput cup $word_title_line $jorek_column
((word_title_line++))
    echo -e "      ${PURPLE}██${NC}║  ╚╝ ╚╝  ${PURPLE}██████${NC}╗ ${PURPLE}███████${NC}╗${PURPLE}██${NC}╗  ${PURPLE}██${NC}╗ "
tput cup $word_title_line $jorek_column
((word_title_line++))
    echo -e "      ${PURPLE}██${NC}║ ${PURPLE}██████${NC}╗ ${PURPLE}██${NC}╔══${PURPLE}██${NC}╗${PURPLE}██${NC}╔════╝${PURPLE}██${NC}║ ${PURPLE}██${NC}╔╝ "
tput cup $word_title_line $jorek_column
((word_title_line++))
    echo -e "      ${PURPLE}██${NC}║${PURPLE}██${NC}╔═══${PURPLE}██${NC}╗${PURPLE}██████${NC}╔╝${PURPLE}█████${NC}╗  ${PURPLE}█████${NC}╔╝  "
tput cup $word_title_line $jorek_column
((word_title_line++))
    echo -e " ${PURPLE}██   ${PURPLE}██${NC}║${PURPLE}██${NC}║   ${PURPLE}██${NC}║${PURPLE}██${NC}╔══${PURPLE}██${NC}╗${PURPLE}██${NC}╔══╝  ${PURPLE}██${NC}╔═${PURPLE}██${NC}╗  "
tput cup $word_title_line $jorek_column
((word_title_line++))
    echo -e " ${NC}╚${PURPLE}█████${NC}╔╝╚${PURPLE}██████${NC}╔╝${PURPLE}██${NC}║  ${PURPLE}██${NC}║${PURPLE}███████${NC}╗${PURPLE}██${NC}║  ${PURPLE}██${NC}╗ "
tput cup $word_title_line $jorek_column
((word_title_line++))
    echo -e "  ${NC}╚════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ "
}

draw_options() {
options_column=$((avr_col-5))
((word_title_line++))
arrow_line=$word_title_line
tput cup $word_title_line $options_column
((word_title_line++))
    echo -e "${BLUE}    START"
tput cup $word_title_line $options_column
((word_title_line++))
    echo -e "${BLUE} INFORMATION"
tput cup $word_title_line $options_column
((word_title_line++))
    echo -e "${BLUE}    EXIT"
                  
}

start_option() {
    tput cup $arrow_line $((options_column-2))
    echo -e "    ${NC}> ${BOLD}START ${NC}<"    
    read -rsn1 KEY
    case "$KEY" in
        "x") 
            source ./jorek.sh
            ;;
        "s")
            tput cup $arrow_line $((options_column-2))
            echo -e "${BLUE}      START  "
            arrow_line=$((arrow_line+1))
            information_option            
            ;;
    esac
}

information_option() {
    tput cup $arrow_line $((options_column-2))
    echo -e " ${NC}>${BOLD} INFORMATION ${NC}<"
    read -rsn1 KEY
    case "$KEY" in
        "x")
            source ./info_page.sh
            ;;
        "w")
            tput cup $arrow_line $((options_column-2))
            echo -e " ${BLUE}  INFORMATION  "
            arrow_line=$((arrow_line-1))
            start_option
            ;;
        "s")
            tput cup $arrow_line $((options_column-2))
            echo -e " ${BLUE}  INFORMATION  "
            arrow_line=$((arrow_line+1))
            exit_option            
            ;;
    esac
}

exit_option() {
    tput cup $arrow_line $((options_column-2))
    echo -e "    ${NC}> ${BOLD}EXIT ${NC}<"
    read -rsn1 KEY
    case "$KEY" in    
        "x")
            exit
            ;;
        "w")
            tput cup $arrow_line $((options_column-2))
            echo -e "${BLUE}      EXIT  "
            arrow_line=$((arrow_line-1))
            information_option
            ;;
    esac            
}

echo -n $border
tput cup $lines 0
echo -n $border
draw_jorek
draw_options
start_option
