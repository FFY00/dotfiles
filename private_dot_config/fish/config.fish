if not status is-interactive
    return
end

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

# OS-specific
switch (uname)
    case Linux
        # Configure GCR as the ssh agent
        set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
        # Use gnome-keyring-daemon for the keyring
        gnome-keyring-daemon --start --components=keyring,pkcs11,secrets 2>/dev/null | eval-shell-vars -U
        # Platform configuration
        set CCACHE_BINDIR /usr/lib/ccache/bin

    case Darwin
        # Start ssh-agent
        ssh-agent -c | eval-shell-vars --shell=csh
        # Homebrew paths
        set -ax PATH /opt/homebrew/opt/python@3.*/libexec/bin
        set -ax PATH /opt/homebrew/opt/coreutils/libexec/gnubin
        set -ax PATH /opt/homebrew/opt/make/libexec/gnubin
        set -ax PATH /opt/homebrew/bin
        # Platform configuration
        set CCACHE_BINDIR /opt/homebrew/opt/ccache/libexec
end

# Set default programs
## Compilers
if set -q CCACHE_BINDIR
    set -x CC $CCACHE_BINDIR/cc
    set -x CXX $CCACHE_BINDIR/c++
end
## General
set -x EDITOR nvim
set -x VISUAL nvim

# Set default arguments
set -ax MAKEFLAGS -j32
set -ax SPHINXOPTS -j32
set -ax PARALLEL_JOBS 32
set -ax FZF_DEFAULT_OPTS --color=bg+:-1  # clear the background color, looks better with the transparency

# Set default configs
set -x VIRTUAL_ENV_DISABLE_PROMPT true
set -x GPG_TTY tty
set -x FORCE_COLOR 1
set -x PYTHON_FROZEN_MODULES off
## Qt
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x QT_AUTO_SCREEN_SCALE_FACTOR 0

# Set dynamic variables
dircolors -c ~/.dircolors | eval-shell-vars --shell=csh
