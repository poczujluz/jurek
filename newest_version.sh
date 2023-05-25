#!/bin/bash

declare -i rows
declare -i columns
declare -A board
declare game_over=false

make_simple_board() {
    rows=10
    columns=20
    box_char_wall="║"
    box_char_floor="═"
    blank=" "
    for ((i=0; i<rows+1; i++)); do
        for ((j=0; j<columns+1; j++)); do
            if ((j == 0 || j == columns)); then
                board[$i,$j]=$box_char_wall
            elif ((i == 0 || i == rows)); then
                board[$i,$j]=$box_char_floor
            else
                board[$i,$j]=$blank
            fi 
        done
    done
    board[0,0]="╔"
    board[10,0]="╚"
    board[0,20]="╗"
    board[10,20]="╝"
}

iniciate_snake() {
    length=2
    tail="o"
    tail_row=6
    tail_column=10
    head="O"
    head_row=6
    head_column=11
    snake_char="o" 
}

#Read
read_input() {
    read -t 0.2 -rsn1 KEY
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
}

out_board() {
    clear
for ((i=0; i<rows+1; i++)); do
    for ((j=0; j<columns+1; j++)); do
        echo -n "${board[$i,$j]}"
    done
  echo
done
}

#Game main
make_simple_board
out_board
iniciate_snake
    tput cup $head_row $head_column
        echo -n $head
    tput cup $tail_row $tail_column
        echo -n $tail
while [[ $game_over == false ]]; do
    read_input 
    snake_move
        tput cup $head_row $head_column
            echo -n $head
done
echo "Game over!"
