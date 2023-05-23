#!/bin/bash

#Wielkosc planszy
SZEROKOSC=20
WYSOKOSC=10
PUNKTY=0
dlugosc_weza=1
waz_y=10
waz_x=5
game_over=false


generator_jedzenia() {
	mysz_y=$((1 + $RANDOM%10))
	mysz_x=$((1 + $RANDOM%20))
}
#Powstanie planszy
plansza() {
    clear
    for ((i=0; i<WYSOKOSC+2; i++)); do
        for ((j=0; j<SZEROKOSC+2; j++)); do
            if ((i == 0 || i == WYSOKOSC+1 || j == 0 || j == SZEROKOSC+1)); then
                echo -n "#"
            elif ((i == waz_y && j == waz_x)); then
                echo -n "O"
            elif ((i == mysz_y && j == mysz_x)); then
                echo -n "@"
            else
                echo -n " "
            fi
        done
        echo
    done
    echo "Score: $score"
}


#Ruch weza
ruch_weza() {
        case "$kierunek" in
		"w") waz_y=$((waz_y - 1));;
		"s") waz_y=$((waz_y + 1));;
		"a") waz_x=$((waz_x - 1));;
		"d") waz_x=$((waz_x + 1));;
	esac
	if ((waz_x == 0 || waz_y == 0 || waz_x == SZEROKOSC+1 || waz_y == WYSOKOSC+1)); then
		game_over=true
	fi
	if ((waz_x == mysz_x && waz_y == mysz_y)); then
		score=$((score+1))
		generator_jedzenia
	fi
}

#Wejscie gracza
odczytaj_wejscie() {
        read -t 0.2 -rsn1 klawisz
        case "$klawisz" in
                "w") kierunek="w";;
                "s") kierunek="s";;
                "a") kierunek="a";;
        	"d") kierunek="d";;
		"q") game_over=true;;
	esac
}

#Main
generator_jedzenia
while [[ $game_over == false ]]; do
	plansza
        odczytaj_wejscie
        ruch_weza
done
echo "Game over!"

                                                                                                                                                                                                                            104,0-1       Bo
