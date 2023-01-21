#!/bin/sh
# Sync mail and give notification if there is new mail.

# Checks for internet connection and set notification script.
ping -q -c 1 1.1.1.1 > /dev/null || exit

export DISPLAY=:0.0

# Run mbsync on all accounts to update local mail
#mbsync -a "$@" # Update all accounts
#mbsync -a "$@" || notify-send -u critical "Mail not syncing!" # If an update fails, then send a notification
# Since I run this as a cron script every two minutes, I don't need a fail notification every two minutes!
# So only send the notification on the top of the hour
mbsync -a "$@" || if date | grep -E ".* [0-9]{2}:[0][0-4]:[0-9]{2} .*" > /dev/null ; then notify-send -u critical "Mail not syncing!" ; fi

# Check all accounts/mailboxes for new mail. Notify if there is new content.
for account in "$HOME/.local/share/mail/"*
do
	acc="$(echo "$account" | sed "s/.*\///")"
	newcount=$(find "$HOME/.local/share/mail/$acc/INBOX/new/" "$HOME/.local/share/mail/$acc/Inbox/new/" "$HOME/.local/share/mail/$acc/inbox/new/" -type f -newer "$HOME/.config/mutt/.mailsynclastrun" 2> /dev/null | wc -l)
	#[ "$newcount" -gt "0" ] && notify-send "$acc" "$newcount" &
	[ "$newcount" -gt "0" ] && notify-send "$newcount new emails for $acc" &
done
notmuch new 2>/dev/null

#Create a touch file that indicates the time of the last run of mailsync
touch "$HOME/.config/mutt/.mailsynclastrun"

