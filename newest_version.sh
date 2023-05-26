#!/bin/bash

declare -i rows
declare -i columns
declare -A board
declare game_over=false
score=0
SNAKE_COLOR='\033[0;32m'
MOUSE_COLOR='\033[0;37m'

make_simple_board() {
    rows=10
    columns=20
    box_char_wall="║"
    box_char_floor="═"
    blank=" "
    for ((i=0; i<$((rows+2)); i++)); do
        for ((j=0; j<$((columns+2)); j++)); do
            if ((j == 0 || j == columns+1)); then
                board[$i,$j]=$box_char_wall
            elif ((i == 0 || i == rows+1)); then
                board[$i,$j]=$box_char_floor
            else
                board[$i,$j]=$blank
            fi 
        done
    done
    board[0,0]="╔"
    board[$((rows+1)),0]="╚"
    board[0,$((columns+1))]="╗"
    board[$((rows+1)),$((columns+1))]="╝"
}


generate_mouse() {
    mouse="■" 
    mouse_row=$(((1+$new_zero_row) + $RANDOM%10))
	mouse_column=$(((1+$new_zero_column) + $RANDOM%20))
    tput cup $mouse_row $mouse_column
    echo -en "${MOUSE_COLOR}$mouse"
}

iniciate_snake() {
    length=2
    tail_row=$((new_zero_row+6))
    tail_column=$((new_zero_column+10))
    head="█"
    head_row=$((new_zero_row+6))
    head_column=$((new_zero_column+10))
    snake_char="o" 
}

#Read
read_input() {
    stty -echo
    read -t 0.2 -rsn1 KEY
    stty echo
    case "$KEY" in
        "w") DIRECTION="w";;
        "s") DIRECTION="s";;
        "a") DIRECTION="a";;
    	"d") DIRECTION="d";;
	    "q") game_over=true;;
	esac
}

snake_move() {
    case "$DIRECTION" in
		"w") 
            tput cup $tail_row $tail_column
                echo -n " "
            tail_row=$head_row
            tail_column=$head_column
            head_row=$((head_row - 1))
        ;;
		"s")     
            tput cup $tail_row $tail_column
                echo -n " "
            tail_row=$head_row
            tail_column=$head_column
            head_row=$((head_row + 1))
            ;;
		"a")  
            tput cup $tail_row $tail_column
                echo -n " "
            tail_row=$head_row
            tail_column=$head_column
            head_column=$((head_column - 1))
            ;;
		"d")     
            tput cup $tail_row $tail_column
                echo -n " "
            tail_row=$head_row
            tail_column=$head_column
            head_column=$((head_column + 1))
            ;;    
    esac
    if ((head_column==mouse_column && head_row==mouse_row)); then
        score=$((score+1))
        generate_mouse
    fi
    if ((head_column==new_zero_column || head_column==new_zero_column+columns+1 || head_row==new_zero_row || head_row==new_zero_row+rows+1)); then
        game_over=true
    fi
}

out_board() {
new_zero_row=$((avr_row-6))
new_zero_column=$((avr_col-12))
for ((i=0; i<rows+2; i++)); do
    tput cup $((i+$new_zero_row)) $new_zero_column
    for ((j=0; j<columns+2; j++)); do
        echo -n "${board[$i,$j]}"
    done
  echo
done
}

#Game main
tput civis
clear
tput cup 0 0
    echo -ne "${NC}#"
    for ((i=0; i<$((cols-2)); i++)); do
        echo -n "-"
    done
    echo -n "#"
tput cup $(($lines+1)) 0
    echo -n "#"
    for ((i=0; i<$((cols-2)); i++)); do
        echo -n "-"
    done
    echo -n "#"
make_simple_board
out_board
iniciate_snake
    tput cup $head_row $head_column
        echo -ne "${SNAKE_COLOR}$head"
    tput cup $tail_row $tail_column
        echo -ne "${SNAKE_COLOR}$head"
generate_mouse
while [[ $game_over == false ]]; do
    read_input 
    snake_move
        tput cup $head_row $head_column
            echo -ne "${SNAKE_COLOR}$head"
done
tput cup $((avr_row-1)) $((avr_col-6))
echo -en "${NC}Game over!!"
stty -echo
sleep 5
stty echo
source ./title_page.sh
