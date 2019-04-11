#!/bin/bash

spotify &
blockify-ui &

sleep 2

i3-msg 'workspace 10'; i3-layout-manager spotify
