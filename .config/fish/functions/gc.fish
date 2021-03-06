function gc --description 'Clone repo and cd into it'
    set -l repo $argv[1]
    set -l name (basename $repo .git)
    if [ (count $argv) -eq 2 ]
        set name $argv[2]
    end

    command git clone $repo $name
    and echo "Changing directory..."
    and cd $name
end
