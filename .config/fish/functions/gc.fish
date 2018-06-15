function gc -d 'Change directory to the repo after clone it'
  set -l repo $argv[1]
  set -l name (basename $repo .git)
  if [ (count $argv) -eq 2 ]
    set name $argv[2]
  end

  command git clone $repo $name
  echo "Changing directory..."
  cd $name
end
