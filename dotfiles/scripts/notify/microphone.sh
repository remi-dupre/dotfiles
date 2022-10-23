#!/bin/bash
source "$(dirname ${BASH_SOURCE[0]})/bar.sh"

BAR_MUTE="·"
ID_FILE=/tmp/.notif_microphone_id
NOTIF_ID=$(cat $ID_FILE || echo "602")


default_source_name() {
    pacmd stat | awk -F": " '/^Default source name: /{print $2}'
}

name() {
    pacmd list-sources |
        awk '/^\s+name: /{indefault = $2 == "<'$(default_source_name)'>"}
            /^\s+device.description = / && indefault {$1=$2=""; gsub(/"|^ +/, ""); print $0; exit}'
}

volume() {
    pacmd list-sources |
        awk '/^\s+name: /{indefault = $2 == "<'$(default_source_name)'>"}
             /^\s+volume: ([0-9]*)/ && indefault {gsub(/%,?/,""); print $5; exit}'
}

muted() {
    pacmd list-sources |
        awk '/^\s+name: /{indefault = $2 == "<'$(default_source_name)'>"}
             /^\s+muted: / && indefault {print $2; exit}'
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
                 "`name`: Off" "" \
    )
else
    NOTIF_ID=$(
        dunstify --printid \
                 --hints "int:value:$(volume)" \
                 --replace=$NOTIF_ID \
                 --icon=notification-microphone-sensitivity-$force \
                 --urgency=$urgency \
                 --timeout=1000 \
                 "`name`: `volume`%" "" \
    )
fi

echo $NOTIF_ID > $ID_FILE
