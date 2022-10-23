#!/bin/bash
source "$(dirname ${BASH_SOURCE[0]})/bar.sh"

BAR_MUTE="·"
ID_FILE=/tmp/.notif_sound_id
NOTIF_ID=$(cat $ID_FILE || echo "600")


default_sink_name() {
    pactl get-default-sink
}

name() {
    pactl list sinks \
        | sed "0,/$(default_sink_name)/d" \
        | grep Description \
        | sed -e 's/^.*Description: \(.*\)$/\1/g' \
        | head -n 1
}

volume() {
    pactl get-sink-volume $(default_sink_name) \
        | head -n 1 | sed -e 's/^.* \([0-9]\+\)%.*$/\1/g'
}

muted() {
    pactl get-sink-mute $(default_sink_name) \
        | sed -e 's/^Mute: \(.*\)$/\1/'
}

# Notification attributes
if [ `volume` -gt "75" ]; then
    force="high"
elif [ `volume` -gt "50" ]; then
    force="medium"
elif [ `volume` -gt "25" ]; then
    force="low"
else
    force="off"
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
                 --icon=notification-audio-volume-muted \
                 --urgency=low \
                 --timeout=1000 \
                 "`name`" "Off" \
    )
else
    echo "int:value:$(volume)"
    NOTIF_ID=$(
        dunstify --printid \
                 --hints "int:value:$(volume)" \
                 --replace=$NOTIF_ID \
                 --icon=notification-audio-volume-$force \
                 --urgency=$urgency \
                 --timeout=1000 \
                 "`name`" "`volume`%" \
    )
fi

echo $NOTIF_ID > $ID_FILE
