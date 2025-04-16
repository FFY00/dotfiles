function gc --description 'Clone repo and cd into it' --argument repo --argument name
    if test -z $name
        set name (basename $repo .git)
    end

    run-command git clone $repo $name || return

    echo "Changing directory..."
    cd $name
end
