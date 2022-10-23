#!/bin/bash
source "$(dirname ${BASH_SOURCE[0]})/bar.sh"

BAR_MUTE="·"
ID_FILE=/tmp/.notif_microphone_id
NOTIF_ID=$(cat $ID_FILE || echo "602")


default_source_name() {
    pactl get-default-source
}

name() {
    pactl list sources \
        | sed "0,/$(default_source_name)/d" \
        | grep Description \
        | sed -e 's/^.*Description: \(.*\)$/\1/g' \
        | head -n 1
}

volume() {
    pactl get-source-volume $(default_source_name) \
        | head -n 1 | sed -e 's/^.* \([0-9]\+\)%.*$/\1/g'
}

muted() {
    pactl get-source-mute $(default_source_name) \
        | sed -e 's/^Mute: \(.*\)$/\1/'
}

# Notification attributes
if [ `volume` -gt "66" ]; then
    force="high"
elif [ `volume` -gt "33" ]; then
    force="medium"
else
    force="low"
fi

if [ `volume` -gt "100" ]; then
    urgency="critical"
else
    urgency="low"
fi

# Display
bar=`progress $(volume)`

if [ `muted` = "yes" ]; then
    NOTIF_ID=$(
        dunstify --printid \
                 --replace=$NOTIF_ID \
                 --icon=notification-microphone-sensitivity-muted \
                 --urgency=low \
                 --timeout=1000 \
                 "`name`" "Off" \
    )
else
    NOTIF_ID=$(
        dunstify --printid \
                 --hints "int:value:$(volume)" \
                 --replace=$NOTIF_ID \
                 --icon=notification-microphone-sensitivity-$force \
                 --urgency=$urgency \
                 --timeout=1000 \
                 "`name`" "`volume`%" \
    )
fi

echo $NOTIF_ID > $ID_FILE
