function rmdeb
    set -lx files *.deb *.deb.*
    rm -rf $files
end
