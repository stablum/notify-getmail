#!/bin/bash
MBOX=~/getmail.mbox
cd ~

while true ; do
    rm -f $MBOX
    touch $MBOX
    getmail -n -v
    STUFF=$(cat $MBOX | egrep '^(Date|Subject|From):')
    if [ ! -z "$STUFF" ] ; then
        echo BEGIN${STUFF}END
        D=$(echo "$STUFF" | egrep '^(Date):' | sed 's/^Date://')
        S=$(echo "$STUFF" | egrep '^(Subject):' | sed 's/^Subject://')
        F=$(echo "$STUFF" | egrep '^(From):' | sed 's/^From://')
        mplayer -ao alsa -quiet /usr/share/popper/popper.wav </dev/null >/dev/null 2>&1 &
        notify-send "$S" "<b>$F</b><br/><i>$D</i>" -t 300000 -u critical -i /usr/share/app-install/icons/gmail-notify-icon.png
    fi
    sleep 15
done
