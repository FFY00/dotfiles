function __fish_ratbagctl_complete
    set -l IFS

    # argv: command line arguments
    set argv (echo $argv | cut -f2- -s -d ' ')
    set argc (count $argv)

    # Options
    if string match -q "0-*" "0$argv"
        echo -e "--version\n--verbose\n--nocommit\n--help"
        set argv (echo $argv | cut -f2- -s -d ' ')
        set argc (count $argv)
    end

    # Device Commands
    if test $argc -le 1 # 1st argument - list command or device name
        echo -e "list\n"(ratbagctl list | cut -f1 -d:)
    else if test $argc -eq 2
        echo -e "info\nname\nprofile\nresolution\nspi\nrate\nbutton\nled"
    end
end
