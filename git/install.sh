OS="`uname -s`"
if [ "$OS" == "Darwin" ]; then
  echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
  killall gpg-agent
fi
