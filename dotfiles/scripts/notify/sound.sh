#!/bin/bash
source "$(dirname ${BASH_SOURCE[0]})/bar.sh"

BAR_MUTE="·"
ID_FILE=/tmp/.notif_sound_id
NOTIF_ID=$(cat $ID_FILE || echo "600")


default_sink_name() {
    pacmd stat | awk -F": " '/^Default sink name: /{print $2}'
}

name() {
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'$(default_sink_name)'>"}
            /^\s+device.description = / && indefault {$1=$2=""; gsub(/"|^ +/, ""); print $0; exit}'
}

volume() {
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'$(default_sink_name)'>"}
             /^\s+volume: ([0-9]*)/ && indefault {gsub(/%,?/,""); print $5; exit}'
}

muted() {
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'$(default_sink_name)'>"}
             /^\s+muted: / && indefault {print $2; exit}'
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
                 "`name`: Off" "<b>${bar//$BAR_FILL/$BAR_MUTE}</b>" \
    )
else
    NOTIF_ID=$(
        dunstify --printid \
                 --replace=$NOTIF_ID \
                 --icon=notification-audio-volume-$force \
                 --urgency=$urgency \
                 --timeout=1000 \
                 "`name`: `volume`%" "<b>$bar</b>" \
    )
fi

echo $NOTIF_ID > $ID_FILE
