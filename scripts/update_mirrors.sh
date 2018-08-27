#!/bin/bash

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
#rankmirrors /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
curl "https://www.archlinux.org/mirrorlist/?country=all&protocol=http&protocol=https&ip_version=4&ip_version=6" -o /etc/pacman.d/mirrorlist.orig
sed -i -e 's/#Server/Server/g' -e '/^#/d' /etc/pacman.d/mirrorlist.orig
rankmirrors /etc/pacman.d/mirrorlist.orig > /etc/pacman.d/mirrorlist
