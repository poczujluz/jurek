#!/bin/bash

declare -A snake
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
    len=2
    tail_row=$((new_zero_row+6))
    tail_column=$((new_zero_column+10))
    head="█"
    head_row=$((new_zero_row+6))
    head_column=$((new_zero_column+11))
    snake[1,0]=$((new_zero_row+6))
    snake[1,1]=$((new_zero_column+11))
    snake[2,0]=$((new_zero_row+6))
    snake[2,1]=$((new_zero_column+10))
    DIRECTION="w"
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

new_tail() {
    tput cup $tail_row $tail_column
        stty echo
        echo -n " "
        stty -echo
    board[$(($tail_row-new_zero_row)),$(($tail_column-$new_zero_column))]=" "
    old_tail_row=$tail_row
    old_tail_column=$tail_column
    tail_row=${snake[$((len-1)),0]}
    tail_column=${snake[$((len-1)),1]}
}


snake_move() {
    new_tail
    case "$DIRECTION" in
		"w") 
            head_row=$((head_row - 1))
        ;;
		"s")     
            head_row=$((head_row + 1))
            ;;
		"a")  
            head_column=$((head_column - 1))
            ;;
		"d")     
            head_column=$((head_column + 1))
            ;;    
    esac
    if ((head_column==mouse_column && head_row==mouse_row)); then
        score=$(($score+1))
        tput cup $(($new_zero_rows+18)) $(($new_zero_column+7))
            stty echo
            echo -en "${NC}$score${GREEN}"
            stty -echo
        len=$(($len+1))
        generate_mouse
        snake[$(($len+1)),0]=$old_tail_column
        snake[$(($len+1)),1]=$old_tail_column
        for ((i=0; i<$((len-1)); i++)); do
            snake[$((len-i)),0]=${snake[$((len-1-i)),0]}
            snake[$((len-i)),1]=${snake[$((len-1-i)),1]}
        done
        snake[1,0]=$head_row
        snake[1,1]=$head_column
        tail_column=$old_tail_column
        tail_row=$old_tail_row
        draw_tail
    else
        for ((i=0; i<$((len-1)); i++)); do
            snake[$((len-i)),0]=${snake[$(($len-1-i)),0]}
            snake[$((len-i)),1]=${snake[$(($len-1-i)),1]}
        done
        snake[1,0]=$head_row
        snake[1,1]=$head_column
    fi
    if [ "${board[$((head_row-new_zero_row)),$((head_column-new_zero_column))]}" != " " ]; then
        game_over=true
    fi
    draw_head
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
tput cup $(($new_zero_rows+18)) $new_zero_column
echo "Score: $score"
}

draw_head() {
    board[$((head_row-new_zero_row)),$((head_column-new_zero_column))]=$head
    tput cup $head_row $head_column
    echo -ne "${SNAKE_COLOR}$head"    
}

draw_tail() {
    board[$((tail_row-new_zero_row)),$((tail_column-new_zero_column))]=$head
    tput cup $tail_row $tail_column
    echo -ne "${SNAKE_COLOR}$head"
}

draw_snake() {
    draw_head
    draw_tail
}


#Game main
tput civis
clear
tput cup 0 0
border="#"$(printf "%0.s-" $(seq 1 $((cols-2))))"#"
tput cup $(($lines+1)) 0
border="#"$(printf "%0.s-" $(seq 1 $((cols-2))))"#"
make_simple_board
out_board
iniciate_snake
draw_snake
generate_mouse
while [[ $game_over == false ]]; do
    read_input 
    snake_move
done
tput cup $((avr_row-1)) $((avr_col-6))
echo -en "${NC}Game over!!"
stty -echo
sleep 5
stty echo
source ./title_page.sh
