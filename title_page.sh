#!/bin/bash

C='\033[0m' #no color
RED='\033[0;31m'
ORANGE='\033[0;33m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1;34m'

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
    echo -e "${BLUE}GAME OPTIONS"
tput cup $word_title_line $options_column
((word_title_line++))
    echo -e "${BLUE}BEST PLAYERS"
tput cup $word_title_line $options_column
((word_title_line++))
    echo -e "${BLUE}INFORMATIONS"
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
            gameoptoins_option            
            ;;
    esac
}

gameoptoins_option() {
    tput cup $arrow_line $((options_column-2))
    echo -e "${NC}>${BOLD} GAME OPTIONS ${NC}<"
    stty -echo
    read -rsn1 KEY
    stty echo
    case "$KEY" in
        "x")
            source ./options_page.sh
            ;;
        "w")
            tput cup $arrow_line $((options_column-2))
            echo -e "${BLUE}  GAME OPTIONS  "
            arrow_line=$((arrow_line-1))
            start_option
            ;;
        "s")
            tput cup $arrow_line $((options_column-2))
            echo -e "${BLUE}  GAME OPTIONS  "
            arrow_line=$((arrow_line+1))
            players_option
            ;;
    esac
}

players_option() {
    tput cup $arrow_line $((options_column-2))
    echo -e "${NC}>${BOLD} BEST PLAYERS ${NC}<"
    stty -echo
    read -rsn1 KEY
    stty echo
    case "$KEY" in
        "x")
            source ./best_players_page.sh
            ;;
        "w")
            tput cup $arrow_line $((options_column-2))
            echo -e "${BLUE}  BEST PLAYERS  "
            arrow_line=$((arrow_line-1))
            gameoptoins_option
            ;;
        "s")
            tput cup $arrow_line $((options_column-2))
            echo -e "${BLUE}  BEST PLAYERS  "
            arrow_line=$((arrow_line+1))
            informations_option            
            ;;
    esac
}

informations_option() {
    tput cup $arrow_line $((options_column-2))
    echo -e "${NC}>${BOLD} INFORMATIONS ${NC}<"
    stty -echo
    read -rsn1 KEY
    stty echo
    case "$KEY" in
        "x")
            source ./info_page.sh
            ;;
        "w")
            tput cup $arrow_line $((options_column-2))
            echo -e "${BLUE}  INFORMATIONS  "
            arrow_line=$((arrow_line-1))
            players_option
            ;;
        "s")
            tput cup $arrow_line $((options_column-2))
            echo -e "${BLUE}  INFORMATIONS  "
            arrow_line=$((arrow_line+1))
            exit_option            
            ;;
    esac
}

exit_option() {
    tput cup $arrow_line $((options_column-2))
    echo -e "    ${NC}> ${BOLD}EXIT ${NC}<"
    stty -echo
    read -rsn1 KEY
    stty echo
    case "$KEY" in    
        "x")
            exit
            ;;
        "w")
            tput cup $arrow_line $((options_column-2))
            echo -e "${BLUE}      EXIT  "
            arrow_line=$((arrow_line-1))
            informations_option
            ;;
    esac            
}
clear
trap 'clear' exit
lines=$LINES
cols=$COLUMNS
avr_col=$((cols/2))
avr_row=$((lines/2))
tput cup 0 0
border="#"$(printf "%0.s-" $(seq 1 $((cols-2))))"#"
tput cup $(($lines+1)) 0
border="#"$(printf "%0.s-" $(seq 1 $((cols-2))))"#"
draw_jorek
draw_options
start_option