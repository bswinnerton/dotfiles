OS="`uname -s`"
if [ $OS = "Darwin" ]; then
  if [[ `uname -m` == 'arm64' ]]; then
    echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
  else
    echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
  fi
  killall gpg-agent
fi
