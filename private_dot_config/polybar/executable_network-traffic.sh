#!/bin/bash

INTERVAL=1
UPDATE_INTERFACES=1
INTERFACES=()

function join_by {
    local d=$1;
    shift;
    echo -n "$1";
    shift;
    printf "%s" "${@/#/$d}";
}

print_bytes() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="0 kB/s"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l ) kB/s"
    else
        bytes="$(echo "scale=1;$1/1000000" | bc -l ) MB/s"
    fi

    printf '%8s' "$bytes"
}

average() {
    diff="$(expr $1 - $2)"
    echo "$(expr ${diff#-} / $INTERVAL)"
}

update_interfaces() {
    found=($(find /sys/class/net -maxdepth 1 -type l -not -name 'docker*' -not -name 'br*' -not -name 'v*' -printf '%f\n'))
    INTERFACES=()
    for int in "${found[@]}"; do
        [ $(cat /sys/class/net/"$int"/operstate) = "up" ] && [ "$int" != 'lo' ] && INTERFACES+=("$int")
    done
}

old_up=-1
old_down=-1
last_update=$UPDATE_INTERFACES
skip=0
while true; do
    down=0
    up=0

    ((last_update++))
    if [ "$last_update" -ge "$UPDATE_INTERFACES" ]; then
        old=${INTERFACES[@]}

        update_interfaces
        last_update=0

        [[ "${old[@]}" != "${INTERFACES[@]}" ]] && skip=1 || skip=0
    fi

    if [ ${#INTERFACES[@]} -gt 0 ]; then
        for interface in "${INTERFACES[@]}"; do
            down=$(expr $down + $(cat /sys/class/net/"$interface"/statistics/rx_bytes))
            up=$(expr $up + $(cat /sys/class/net/"$interface"/statistics/tx_bytes))
        done

        if [ $skip -eq 0 ]; then
            echo "$(join_by ', ' "${INTERFACES[@]}") %{T11}🠉%{T-} $(print_bytes $(average $old_up $up)) %{T11}🠋%{T-} $(print_bytes $(average $old_down $down))"
        fi
     else
        echo
     fi

    old_down=$down
    old_up=$up
    sleep $INTERVAL
done

