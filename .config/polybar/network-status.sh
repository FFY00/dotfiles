#!/bin/bash

INTERVAL=1

disconnected='F#f98686'
connected='F#82fc82'

function join_by {
    local d=$1;
    shift;
    echo -n "$1";
    shift;
    printf "%s" "${@/#/$d}";
}

last_update=$UPDATE_INTERFACES
while true; do
    bar=()
    for interface in $(find /sys/class/net -maxdepth 1 -type l -printf '%f\n' | sort -r); do
        [ $(cat /sys/class/net/"$interface"/carrier) == "1" ] && color="%{$connected}" || color="%{$disconnected}"

        if [[ $interface == e* ]]; then
            [ $(cat /sys/class/net/"$interface"/carrier) == "1" ] && symbol='' || symbol='%{T10}%{T-}'
        elif [[ $interface == w* ]]; then
            [ $(cat /sys/class/net/"$interface"/carrier) == "1" ] && symbol='%{T9}%{T-}' || symbol=''
        else
            continue
        fi

        bar+=("$color$symbol%{F-}")
    done

    echo "$(join_by '  ' "${bar[@]}")"

    sleep $INTERVAL
done
