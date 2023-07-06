#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_brightness {
  xbacklight -get | cut -d '.' -f 1
}

function send_notification {
  icon='preferences-system-brightness-lock'
  brightness=$(get_brightness)
  dunstify \
    -h string:synchronous:backlight \
    -h int:value:$brightness \
    -i "$icon" \
    -r 5555 \
    -u normal \
    'Brightness'
}

case $1 in
  up)
    # increase the backlight by 5%
    xbacklight -inc 5
    send_notification
    ;;
  down)
    # decrease the backlight by 5%
    xbacklight -dec 5
    send_notification
    ;;
esac
