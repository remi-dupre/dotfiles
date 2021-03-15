#!/bin/bash
export BAR_WIDTH=37
export BAR_VOID=" "
export BAR_FILL="="

# progress "percent" - display a progress bar
progress() {
    percent=$1

    nb_dashes=$(($BAR_WIDTH * $percent / 100))
    nb_dashes=$(($nb_dashes > $BAR_WIDTH ? $BAR_WIDTH : $nb_dashes))
    nb_spaces=$(($BAR_WIDTH - $nb_dashes))

    echo -n "[";
    for i in $(seq $nb_dashes); do echo -n "$BAR_FILL"; done;
    for i in $(seq $nb_spaces); do echo -n "$BAR_VOID"; done;
    echo -n "]"
}
