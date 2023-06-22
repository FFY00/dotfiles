
set -ax PATH ~/.local/bin
set -ax PATH ~/.cargo/bin
set -ax PATH ~/.cabal/bin
set -ax PATH ~/.dotnet/tools

# Set default programs
## Compilers
set -x CC /usr/lib/ccache/bin/cc
set -x CXX /usr/lib/ccache/bin/cxx
## General
set -x EDITOR nvim

# Set default arguments
set -ax MAKEFLAGS -j32
set -ax SPHINXOPTS -j32
set -ax FZF_DEFAULT_OPTS --color=bg+:-1

# Set default configs
#set -x CCACHE_PREFIX 'distcc'
#set -x DISTCC_HOSTS 'horus'
set -x VIRTUAL_ENV_DISABLE_PROMPT true
set -x GPG_TTY tty

# Set dynamic variables
eval (dircolors -c ~/.dircolors)

# OS-specific
switch (uname)
    case Linux
        for line in (gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
            set -xU (string split '=' $line)
        end

    case Darwin
        eval (ssh-agent -c) >/dev/null

        set -ax PATH /opt/homebrew/opt/python@3.11/libexec/bin
        set -ax PATH /opt/homebrew/opt/coreutils/libexec/gnubin
        set -ax PATH /opt/homebrew/bin
end
