#!/usr/bin/env bash

# Use: Just a simple calendar
# Dependencies: ncal, sed, date, cut, rofi
# Description: shows current month calendar
# Working: basic textfu and rofi dmenu mode
# Author: totoro

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
THEME="$DIR/theme"

# remove the top line and the highlight
MAIN=$(ncal -b -h| awk 'NR>2 {print}')

SUN=$(echo "$MAIN" | cut -c 1,2)
MON=$(echo "$MAIN" | cut -c 4,5)
TUE=$(echo "$MAIN" | cut -c 7,8)
WED=$(echo "$MAIN" | cut -c 10,11)
THR=$(echo "$MAIN" | cut -c 13,14)
FRI=$(echo "$MAIN" | cut -c 16,17)
SAT=$(echo "$MAIN" | cut -c 19,20)

VAL="$SUN\n$MON\n$TUE\n$WED\n$THR\n$FRI\n$SAT"

DATE=$(date +'%_d')
DAY_STR=$(date +'%A')
MONTH=$(date +'%_m')
MONTH_STR=$(date +'%b')
YEAR=$(date +'%Y')

# PROMPT="<span size=\"large\">$DATE</span><sup>-$MONTH_STR  <i>$DAY_STR</i></sup>"
PROMPT="$DATE-$MONTH_STR $DAY_STR"

# make current date active
ACTIVE=$(echo -e "$VAL" | grep -m 1 -n "$DATE" | cut -d':' -f1)
((ACTIVE = ACTIVE - 1))

# for printing 
# su mo tu we th fr sa, 
# you have to fix this every time you change the size in theme
PROMPT2="<span foreground=\"#e06b74\"><b>Su  Mo  Tu  We  Th  Fr  Sa</b></span>"

SELECT=$(echo -e "$VAL" | rofi -dmenu -no-custom -mesg "$PROMPT2" \
    -theme "$THEME" \
    -matching prefix \
    -select "$DATE" \
    -u "0,1,2,3,4,5" \
    -a "$ACTIVE" \
    -p "      $PROMPT")

FILE="$(echo "$SELECT" | sed 's/\ //g')"

if [ -z "$FILE" ]; then
    echo "empty $FILE"
    exit
fi

## here is the journal part

NOTES_DIR="$HOME/Documents/Journal/$YEAR/$MONTH"
FILE="$NOTES_DIR/$(printf "%02d\n" "$FILE").md"
EDITOR="vim"

mkdir -p "$NOTES_DIR"
touch "$FILE"

alacritty -e "$EDITOR" "$FILE"
