#!/bin/bash
# Script name: /lib/systemd/system-sleep/hibernation-lid.sh
# Purpose: Disable wakeup events when hibernating

if [ "$2" = "hibernate" ]; then
    # Hibernating. Disabling/Re-enabling lid wakeup events.
    echo LID > /proc/acpi/wakeup
fi
