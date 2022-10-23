#!/bin/bash
source "$(dirname ${BASH_SOURCE[0]})/bar.sh"

ID_FILE=/tmp/.notif_brightness_id
NOTIF_ID=$(cat $ID_FILE || echo "601")

brightness() {
    echo $((100 * `brightnessctl get` / `brightnessctl max`))
}

# Build progress bar
if [ `brightness` -gt "80" ] ; then
    force="full"
elif [ `brightness` -gt "60" ] ; then
    force="high"
elif [ `brightness` -gt "40" ] ; then
    force="medium"
elif [ `brightness` -gt "20" ] ; then
    force="low"
else
    force="off"
fi

NOTIF_ID=$(
    dunstify --printid \
             --hints "int:value:$(brightness)" \
             --replace=$NOTIF_ID \
             --icon=notification-display-brightness-$force \
             --urgency=low \
             --timeout=1000 "Brightness" "`brightness` %"
)

echo $NOTIF_ID > $ID_FILE
