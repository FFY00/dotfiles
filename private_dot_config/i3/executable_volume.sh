#!/bin/bash

# config
notification_id=1000
over_volume_color=#e96163

# defaults
vol_limit=130
kind=out

usage_text="\
Usage: $0 [options]
Control the volume and issue an action notification.

Options:
  -d <value>        decrease volume
  -i <value>        increase volume
  -v <value>        set volume
  -t                toggle mute
  -l <value>        volume limit (default: $vol_limit)
  -k (in|out)       device kind (default: $kind)
  -h                display this help and exit
"

usage() {
    printf "$usage_text"
    exit ${1:-0}
}

is_number() {
    for arg in "$@"; do
        if [[ ! -z $arg ]] && [[ ! $arg =~ ^[0-9]+$ ]]; then
            echo "Invalid number: $arg"
            set fail=1
        fi
    done
    [[ -z $fail ]] || exit 1
}

get_icon_name() {
    local muted=$1
    local vol=$2

    local type
    local status

    if [[ $kind == in ]]; then
        type=microphone-sensitivity
    else
        type=audio-volume
    fi

    if [[ $muted == true ]]; then
        status=muted
    elif [[ $vol -ge 70 ]]; then
        status=high
    elif [[ $vol -ge 40 ]]; then
        status=medium
    else
        status=low
    fi

    echo $type-$status
}

notify() {
    local muted=$1
    local vol=$2

    local msg
    local args=(
        -h string:synchronous:volume
        -i $(get_icon_name $status)-symbolic
        -r $notification_id
    )

    if [ $muted == true ]; then
        msg='Muted'
    else
        msg='Volume'
        args+=(-h int:value:$vol)
        # change the progress bar color if the volume is over 100%
        if [[ $vol -gt 100 ]]; then
            msg="$msg ($vol%)"
            args+=(-h string:hlcolor:$over_volume_color)
        fi
    fi

    dunstify ${args[@]} "$msg"
}

run() {
    local opt=$1
    local value="$2"

    is_number "$value" $vol_limit

    local args=(
        --get-mute
        --get-volume
        --allow-boost
        --set-limit $vol_limit
    )
    [ $kind == in ] && args+=(--default-source)

    local status=$(pamixer ${args[@]} $opt $value)

    notify $status
}

while getopts "d:i:v:tl:d:k:h" arg; do
    case "$arg" in
        d | i)
            opt=-$arg
            value="$OPTARG"
            ;;
        v)
            opt=--set-volume
            value="$OPTARG"
            ;;
        t)
            opt=-t
            ;;
        l)
            vol_limit="$OPTARG"
            ;;
        k)
            kind="$OPTARG"
            ;;
        h)
            usage
            ;;
        *)
            exit 1
            ;;
    esac
done

[[ -z $opt ]] && usage 1

if [[ "$kind" != in ]] && [[ $kind != out ]]; then
    echo "Invalid kind: $kind (valid values are 'in' and 'out')"
    exit 1
fi

run $opt "$value"
