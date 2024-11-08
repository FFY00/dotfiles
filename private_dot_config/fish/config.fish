# Set fish settings
set -g fish_greeting

# Enable /usr/local libraries
set -ax LD_LIBRARY_PATH /usr/local/lib

# Set PATH
set -ax PATH ~/.local/bin
set -ax PATH ~/.cargo/bin
set -ax PATH ~/.cabal/bin
set -ax PATH ~/.dotnet/tools
set -ax PATH ~/go/bin

# Set default programs
## Compilers
set -x CC /usr/lib/ccache/bin/cc
set -x CXX /usr/lib/ccache/bin/c++
## General
set -x EDITOR nvim
set -x VISUAL nvim

# Set default arguments
set -ax MAKEFLAGS -j32
set -ax SPHINXOPTS -j32
set -ax FZF_DEFAULT_OPTS --color=bg+:-1  # clear the background color, looks better with the transparency

# Set default configs
set -x VIRTUAL_ENV_DISABLE_PROMPT true
set -x GPG_TTY tty
## Qt
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x QT_AUTO_SCREEN_SCALE_FACTOR 0

# Set dynamic variables
eval (dircolors -c ~/.dircolors)

# OS-specific
switch (uname)
    case Linux
        for line in (gnome-keyring-daemon --start --components=keyring,pkcs11,secrets)
            set -xU (string split '=' $line)
        end
        set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh

    case Darwin
        eval (ssh-agent -c) >/dev/null

        set -ax PATH /opt/homebrew/opt/python@3.11/libexec/bin
        set -ax PATH /opt/homebrew/opt/coreutils/libexec/gnubin
        set -ax PATH /opt/homebrew/bin
end
