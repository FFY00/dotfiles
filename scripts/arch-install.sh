#!/bin/bash

function cmd {
    printf "%b" "$reset"
    echo -e "$gray+ $1$reset"
    bash -c "$1"
}

reset="\e[0m"
bold="\e[1m"
gray="\e[90m"
yellow="\e[93m"
green="\e[32m"
cyan="\e[36m"
lblue="\e[94m"
lred="\e[91m"

PS3='Please enter your choice: '
options=("Setup" "Create Account" "Bootloader (GRUB)" "Display Manager (Lightdm w/ litarvan theme)" "Install Packages" "Quit")

if [[ $EUID -ne 0 ]]; then
   echo -e "${lred}This script must be run as root$reset" 1>&2
   exit 1
fi

printf "%b" "$yellow"
select opt in "${options[@]}"
do
    case $opt in
        "Setup")
            echo

            ## Info
            # Boot mode
            printf "%bBoot mode: %b%b" "$cyan" "$bold" "$green"
            (ls /sys/firmware/efi/efivars &> /dev/null) && echo "UEFI" || echo "Legacy"
            printf "%b" "$reset"
            # Network check
            printf "%bNetwork: " "$cyan"
            if (ping -c 1 archlinux.org &> /dev/null); then
                echo -e "$bold${green}ON$reset"
            else
                echo -e "$bold${lred}OFF$reset"
                echo -e "\n${lred}Ping failed!"
                printf "Do you want to continue? (y/N) " && read -r quit

                if [ "$quit" != "y" ] && [ "$quit" != "Y" ]; then
                    echo -e "$yellow"
                    continue
                fi
            fi

            # Mirrors
            echo -e "\n${lblue}Please reorder the mirrorlist putting the preferred ones first."
            printf "Press any key to edit /etc/pacman.d/mirrorlist..." && read -r
            echo && cmd "vim /etc/pacman.d/mirrorlist"

            # Enable NTP
            cmd "timedatectl set-ntp true"
            echo

            # Keyboard layout
            echo -e "${lblue}Please choose a keyboard layout."
            printf "Press any key to see the avaliable options..." && read -r
            echo && cmd "find /usr/share/kbd/keymaps -type f -name '*.map.gz' | less" && echo

            printf "%bKeyboard layout: %b" "$cyan" "$green" && read -r kb_layout
            echo
            [ -z "$kb_layout" ] || cmd "loadkeys $kb_layout"

            ## Partition
            # Disk
            cmd "fdisk -l" && echo
            printf "%bSelect a disk to partition: %b" "$cyan" "$green" && read -r disk
            echo
            [ -z "$disk" ] || cmd "parted $disk"
            cmd "fdisk -l" && echo
            # Install Partition
            printf "%bInstall partition: %b" "$cyan" "$green" && read -r ipartition
            if ! (partprobe -d "$ipartition" &> /dev/null); then
                echo -e "${lred}Invalid partition. Exiting...\n$yellow"
                continue
            fi
            # Filesystem
            printf "%bFilesystem (mkfs.?): (default=ext4) %b" "$cyan" "$green" && read -r filesystem
            if [ -z "$filesystem" ]; then
                filesystem=ext4
            fi
            echo && cmd "mkfs.$filesystem $ipartition" && echo
            # Swap
            printf "%bSwap partition: (default=none) %b" "$cyan" "$green" && read -r spartition
            [ -z "$spartition" ] || echo
            [ -z "$spartition" ] || cmd "mkswap $spartition"
            [ -z "$spartition" ] || cmd "swapon $spartition"
            [ -z "$spartition" ] || echo
            # Boot
            printf "%bBoot partition: (default=none) %b" "$cyan" "$green" && read -r bpartition
            echo
            if [ ! -z "$bpartition" ]; then
                if (ls /sys/firmware/efi/efivars &> /dev/null); then
                    # EFI
                    cmd "mkfs.fat -F32 $bpartition"
                else
                    # Legacy
                    printf "%bBoot partition filesystem (mkfs.?): (default=ext4) %b" "$cyan" "$green" && read -r bfilesystem
                    if [ -z "$bfilesystem" ]; then
                        filesystem=ext4
                    fi
                    echo && cmd "mkfs.$filesystem $bpartition" && echo
                fi
            fi

            # Mount
            cmd "mount $ipartition /mnt"
            cmd "mkdir /mnt/boot"
            [ -z "$bpartition" ] || cmd "mount $bpartition /mnt/boot"

            # Install
            cmd "pacstrap /mnt base base-devel"
            cmd "genfstab -U /mnt >> /mnt/etc/fstab"
            echo

            # Timezone
            echo -e "${lblue}Please select the timezone."
            printf "Press any key to see the avaliable options..." && read -r
            echo && cmd "arch-chroot /mnt find /usr/share/zoneinfo/{Africa,America,Antarctica,Arctic,Asia,Atlantic,Australia,Brazil,Canada,Chile,Etc,Europe,Indian,Mexico,Pacific} | sed 's|/usr/share/zoneinfo/||g' | less" && echo
            printf "%bTimezone: (default=Etc/UTC) %b" "$cyan" "$green" && read -r timezone
            if [ ! -f "/mnt/usr/share/zoneinfo/$timezone" ]; then
                timezone="Etc/UTC"
            fi
            echo && cmd "arch-chroot /mnt ln -sf /usr/share/zoneinfo/$timezone /etc/localtime"

            # Sync to hardware clock
            cmd "arch-chroot /mnt hwclock --systohc"

            # Locale
            echo -e "\n${lblue}Please enable your preferred locale."
            printf "Press any key to edit /mnt/etc/locale.conf..." && read -r
            echo
            cmd "vim /mnt/etc/locale.conf"
            cmd "arch-chroot /mnt locale-gen"
            echo

            # Hostname
            printf "%bHostname: (default=archlinux)%b" "$cyan" "$green" && read -r hostname
            if [ -z "$hostname" ]; then
                hostname=archlinux
            fi
            echo && cmd "echo $hostname > /mnt/etc/hostname"

            # Hosts file
            cmd "echo '127.0.0.1	localhost' > /mnt/etc/hosts"
            echo

            # Root account
            printf "%bRoot password: (default=disabled)" "$cyan"
            echo && cmd "arch-chroot /mnt passwd" && echo

            printf "%b" "$yellow"
            ;;
        "Create Account")
            echo

            # Name
            printf "%bUsername: %b" "$cyan" "$green" && read -r username
            if [ -z "$username" ]; then
                echo -e "$yellow"
                continue
            fi
            echo && cmd "arch-chroot /mnt useradd -g users -G wheel -m $username" && echo

            # Password
            echo -e "${cyan}Password: (default=disabled)"
            echo && cmd "arch-chroot /mnt passwd $username" && echo

            # Sudo
            echo -e "${lblue}You might want to enable sudo permissions for the wheel group."
            printf "Press any key to edit /mnt/etc/sudoers..." && read -r
            echo
            cmd "vim /mnt/etc/sudoers"
            echo

            printf "%b" "$yellow"
            ;;
        "Bootloader (GRUB)")
            if [ -z "$bpartition" ]; then
                bpartition=$ipartition
            fi

            if [ -z "$bpartition" ]; then
                echo
                echo -e "${lred}Missing boot partition!$yellow"
                echo
                continue
            fi

            echo
            cmd "arch-chroot /mnt pacman -S grub"

            if (ls /sys/firmware/efi/efivars &> /dev/null); then
                # EFI
                cmd "arch-chroot /mnt pacman -S efibootmgr"
                cmd "arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ARCH"
            else
                # Legacy
                cmd "arch-chroot /mnt grub-install --target=i386-pc $bpartition"
            fi

            cmd "arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg"
            echo

            printf "%b" "$yellow"
            ;;
        "Display Manager (Lightdm w/ litarvan theme)")
            echo
            cmd "arch-chroot /mnt pacman -S lightdm lightdm-webkit-theme-litarvan"
            cmd "sed -i 's|^#greeter-session=.*|greeter-session=lightdm-webkit2-greeter|' /mnt/etc/lightdm/lightdm.conf"
            cmd "sed -i 's|^webkit_theme        =.*|webkit_theme        = litarvan|' /mnt/etc/lightdm/lightdm-webkit2-greeter.conf"
            cmd "arch-chroot /mnt systemctl enable lightdm"
            echo

            printf "%b" "$yellow"
            ;;
        "Install Packages")
            echo

            # Misc packages
            echo -e "${lblue}Packages to be installed: vim neovim tree pkgfile fish"
            printf "%bDo you want to proceed? (Y/n) %b" "$cyan" "$green" && read -r quit
            if [ "$quit" != "n" ] && [ "$quit" != "N" ]; then
                echo
                cmd "arch-chroot /mnt pacman -S vim neovim tree pkgfile fish"
                echo
            fi

            # Xorg
            printf "%bDo you want to install xorg? (Y/n) %b" "$cyan" "$green" && read -r quit
            if [ "$quit" != "n" ] && [ "$quit" != "N" ]; then
                echo
                cmd "arch-chroot /mnt pacman -S xorg"
                echo
            fi

            printf "%bWhich other packages do you want to install? (default=none) %b" "$cyan" "$green" && read -r packages
            [ -z "$packages" ] || echo
            [ -z "$packages" ] || cmd "arch-chroot /mnt pacman -S $packages"
            [ -z "$packages" ] || echo

            printf "%b" "$yellow"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# vim:set ts=4 sw=4 et:
