#!/bin/sh
# Declare where the abook dictionary is
BOOK=$HOME/.abook/addressbook 

# Get the name of the phone device
DEVICENAME="$(kdeconnect-cli --list-available | sed 1q | awk '{ print $2 }' | sed 's/://g')" 

# Pick the name of the person you are sending a message to
NAMELINE="$(grep -i "^name=" $BOOK | ~/scripts/dmenu.sh)"
NAME="$(echo $NAMELINE | sed 's/^name=//g')"

# Pick the phone number for that person
PHONENUM="$(grep -i -A 10 "$NAMELINE" $BOOK | sed -z 's/\n/;;/g' | sed 's/\[[0-9]*\].*//g' | sed 's/;;/\n/g' | grep -iE "mobile|phone" | ~/scripts/dmenu.sh | sed 's/[a-zA-Z]*=//g')"

# If the phone number collected is not exactly 10 digits, then it is not valid
if ! [ "$(echo $PHONENUM | sed -E 's/[0-9]{10}//g')" = "" ] ; then 
    exit 1 # The script fails, exit false
fi

echo "Enter your SMS Message Body:"
read MSG

echo ""
echo "Confirm the following message to $NAME at $PHONENUM with the following body:"
echo "$MSG"
echo ""
echo "Confirm? [y/N]: "
read CONFIRMED

if ! [ "$(echo "$CONFIRMED" | tr '[:upper:]' '[:lower:]')" = "y" ] ; then 
    echo "Message cancelled"
    exit 1
fi

# This is for testing
#kdeconnect-cli -n "$DEVICENAME" --ping-msg "$PHONENUM"
#kdeconnect-cli -n "$DEVICENAME" --ping-msg "$MSG"

# Okay send the message
kdeconnect-cli -n "$DEVICENAME" --destination "$PHONENUM" --send-sms "$MSG"
