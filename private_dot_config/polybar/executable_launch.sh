#!/bin/bash

if ! polybar-msg cmd restart >/dev/null; then
    polybar top & disown
fi
