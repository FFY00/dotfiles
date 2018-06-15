# Dotfiles
My personal dotfiles

#### Scripts

`life_saver.pl` (Usage: `sudo ./life_saver.pl "Part of the text to find (doesn't need to be literal, it can be a similar text)"`)
This is a script that I found [here](http://etherealbits.com/2012/06/the-perl-script-that-may-save-your-life/) after I accidentally `rm -rf` my work (yes, I am dumb like that). It searches the content of `/dev/sda1` for the specified text (or a something similar) and prints it. You should be able to recover your deleted files with this.

`scripts/update_mirrors.sh` (Usage: `sudo ./update_mirrors.sh`)
This is a simple script to update the mirrors on an Arch Linux installation. I run this as a cron job.

#### Fish
Includes my custom fish shell functions.

#### Hexchat
Includes a set of plugins. They are written in Lua, TCL and Python. You need to have support for these languages enabled.

#### Vim
Includes Vim with the YouCompleteMe framework. Requires python support so you may need to compile vim yourself.

Visual mode is disabled by default.

#### Neovim
Includes a set of plugins.
###### Disabled for now, I will commit them later.

#### Htop
BlackNight color scheme is enabled by default. You may want to disable it acording to your ui.
