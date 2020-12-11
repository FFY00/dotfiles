bash -c 'eval $(dircolors -b ~/.dircolors)'

set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.dotnet/tools $PATH

for var in (gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    set -xU (echo $var | string split '=')
end
