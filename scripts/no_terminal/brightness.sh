#!/bin/bash 
#This script will take an argument and adjust screen brighness
#This is done by editing /sys/class/backlight/$GRAPHICSMODULE/brightness

#Checking and selecting existing graphics modules
BACKLIGHTDIR=/sys/class/backlight
GRAPHICSMODULE=$(ls -1 $BACKLIGHTDIR)
#-1 is for separating arguments by line rather than space
if [[ $(echo "$GRAPHICSMODULE" | wc -l) == 0 ]]; then
#Need quotations around $GRAPHICSMODULE to preserve newline separator
        echo "ERROR: There appears to be no graphics modules in "$BACKLIGHTDIR
        exit 1
fi
#If multiple cards, select one
if [[ $(echo "$GRAPHICSMODULE" | wc -l) != 1 ]]; then
        GRAPHICSMODULE=$(echo "$GRAPHICSMODULE" | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')
        #GRAPHICSMODULE=$(echo "$GRAPHICSMODULE" | rofi -dmenu)
fi

#Checking for brightness option for graphics module
DIRECTORY=$BACKLIGHTDIR/$GRAPHICSMODULE
if [[ $(ls -1 $DIRECTORY/brightness | wc -l) != 1 ]]; then
        echo "ERROR: Graphics module "$GRAPHICSMODULE "does not have option \"brightness\"; file does not exist in" $BACKLIGHTDIR
        exit 1
fi

#Checking for read/write permissions
#Print r/w string with stat -c %A $FILE. Last character is user executable, 2nd to last writable, 3rd readable
#Shave off last character with sed s'/.$//'
#Print last character with sed -e 's/\(^.*\)\(.$\)/\2/'

#Readable?
if [[ $(stat -c %A $DIRECTORY/brightness | sed s'/.$//' | sed s'/.$//' | sed -e 's/\(^.*\)\(.$\)/\2/') != 'r' ]]; then
        echo "ERROR: "$DIRECTORY"/brightness is not readable. Try chmod 666 on that file."
        exit 1
fi
#Writeable?
if [[ $(stat -c %A $DIRECTORY/brightness | sed s'/.$//' | sed -e 's/\(^.*\)\(.$\)/\2/') != 'w' ]]; then
        echo "ERROR: "$DIRECTORY"/brightness is not writable. Try chmod 666 on that file."
        exit 1
fi

#Checking max brightness
if [[ $(ls -1 $DIRECTORY/max_brightness | wc -l) != 1 ]]; then
        if [[ $(stat -c %A $DIRECTORY/max_brightness | sed s'/.$//' | sed s'/.$//' | sed -e 's/\(^.*\)\(.$\)/\2/') != 'r' ]]; then
                echo "ERROR: "$DIRECTORY"/max_brightness does not exist or is not readable. Cannot determine scaling."
                exit 1
        fi
fi
MAXBRIGHTNESS=$(cat $DIRECTORY/max_brightness)
#Need to declare as integer to do math on. Noninteger numbers will be rounded down to the nearest integer.
declare -i MAXBRIGHNESS

#Select brightness as percent
SELECTION=$(echo -e "100%\n90%\n80%\n70%\n60%\n50%\n40%\n30%\n20%\n10%" | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')
#SELECTION=$(echo -e "100%\n90%\n80%\n70%\n60%\n50%\n40%\n30%\n20%\n10%" | rofi -dmenu)
#Shave off percent symbol
SELECTION=$(echo $SELECTION | sed s'/.$//')
#Scale to max brightness
declare -i SELECTION
SELECTION=$SELECTION*$MAXBRIGHTNESS/100

#Actually make change by writing file
echo $SELECTION > $DIRECTORY/brightness
