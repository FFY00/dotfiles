set -g EDITOR nvim

set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.cabal/bin $PATH
set -gx PATH ~/.dotnet/tools $PATH
set -gx PATH /opt/homebrew/opt/python@3.11/libexec/bin $PATH
set -gx PATH /opt/homebrew/opt/coreutils/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/bin $PATH

set -g CC 'ccache-cc'
set -g CXX 'ccache-cxx'
#set -g CCACHE_PREFIX 'distcc'
#set -g DISTCC_HOSTS 'horus'
set -g MAKEFLAGS '-j32'
set -g SPHINXOPTS '-j32'

set -gx VIRTUAL_ENV_DISABLE_PROMPT true

bash -c 'eval $(dircolors -b ~/.dircolors)'

switch (uname)
    case Linux
        for var in (gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
            set -xU (echo $var | string split '=')
        end
    case Darwin
        eval (ssh-agent -c) >/dev/null
end
