function gpg-secret --wraps='gpg --with-keygrip --with-fingerprint --keyid-format=short -K' --description 'alias gpg-secret=gpg --with-keygrip --with-fingerprint --keyid-format=short -K'
  gpg --with-keygrip --with-fingerprint --keyid-format=short -K $argv
        
end
