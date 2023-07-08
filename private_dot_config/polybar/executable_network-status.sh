#!/bin/bash

INTERVAL=1

disconnected='F#f98686'
connected='F#82fc82'

wired_up=''
#wired_down='%{T10}%{T-}'
wired_down=''  # XXX
wireless_up='%{T9}%{T-}'
wireless_down=''

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
        [ $(cat /sys/class/net/"$interface"/operstate) = "up" ] && color="%{$connected}" || color="%{$disconnected}"

        if [[ $interface == e* ]]; then
            [ $(cat /sys/class/net/"$interface"/operstate) = "up" ] && symbol=$wired_up || symbol=$wired_down
        elif [[ $interface == w* ]]; then
            [ $(cat /sys/class/net/"$interface"/operstate) = "up" ] && symbol=$wireless_up || symbol=$wireless_down
        else
            continue # Not interested (ex: docker, virtual adapters, etc.)
        fi

        bar+=("$color$symbol%{F-}")
    done

    echo $(join_by '  ' "${bar[@]}")

    sleep $INTERVAL
done

