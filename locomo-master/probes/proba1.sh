#!/usr/bin/env bash

# Reset terminal on exit
trap 'tput cnorm; tput sgr0; clear' EXIT

# invisible cursor, no echo
tput civis
stty -echo
max_x=$(($(tput cols) - ${#text}))
max_y=$(($(tput lines) - ${#text}))
text="W"
textB="W"
textA="W"
dir=1 x=$(($max_x / 2)) y=$max_y
#color=`echo $(($RANDOM%9))`
color=3
num=`echo $(($RANDOM%9))`
text1="$num"
dira=1 xa=`echo $(($RANDOM%$max_x))` ya=1
vidas=3
vidasD="<3 <3 <3"
puntos=0


while sleep 0.1 # GNU specific!
do
  x1=$(($x + 1))
  x2=$(($x + 2))
    # move and change direction when hitting walls
    (( ya == 0 || ya == max_y )) && \
        ((dira *= -1))
    (( ya += dira ))
    if [ $ya -eq $max_y ];
    then
      if [[ $xa -eq $x ]];
      then
        puntos=$(($puntos + $num))
        xa=`echo $(($RANDOM%$max_x))`
        ya=1
        num=`echo $(($RANDOM%5))`
        text1="$num"
      elif [[ $xa -eq $x1 ]];
      then
        puntos=$(($puntos + $num))
        xa=`echo $(($RANDOM%$max_x))`
        ya=1
        num=`echo $(($RANDOM%5))`
        text1="$num"
      elif [[ $xa -eq $x2 ]];
      then
        puntos=$(($puntos + $num))
        xa=`echo $(($RANDOM%$max_x))`
        ya=1
        num=`echo $(($RANDOM%5))`
        text1="$num"
      else
        ya=1
        xa=`echo $(($RANDOM%$max_x))`
        vidas=$(($vidas -1))
        num=`echo $(($RANDOM%5))`
        text1="$num"
        if [ $vidas -eq 2 ];
        then
          vidasD="<3 <3"
        elif [ $vidas -eq 1 ];
        then
          vidasD="<3"
        elif [ $vidas -eq 0 ];
        then
          printf "%s" "    GAME OVER"
          vidasD="  "
          tput cup "1" "1"
          printf "%s" "Vidas: $vidasD"
          sleep 2
          vidas=3
          vidasD="<3 <3 <3"
          puntos=0
          x=$(($max_x / 2))
        fi
        if [[ $xa -eq "0" ]];
        then
          xa=1
        fi
      fi
    fi

    # read all the characters that have been buffered up
    while IFS= read -rs -t 0.0001 -n 1 key
    do
        [[ $key == d ]] && (( x++ ))
        [[ $key == a ]] && (( x-- ))
    done

    # batch up all terminal output for smoother action
    framebuffer=$(
        clear
        tput cup "$y" "$x"
        tput setaf "$color"
        printf "%s%s%s" "$text" "$textA" "$textB"
        tput cup "$ya" "$xa"
        tput setaf "$color"
        printf "%s" "$text1"
        tput cup "1" "1"
        printf "%s" "Vidas: $vidasD"
        tput cup "1" "20"
        printf "%s" "Puntuación: $puntos"
    )
    # dump to screen
    printf "%s" "$framebuffer"
done
