OS="`uname -s`"
if [ $OS = "Darwin" ]; then
  mkdir -p ~/.gnupg

  if [[ `uname -m` == 'arm64' ]]; then
    pinentry_program="pinentry-program /opt/homebrew/bin/pinentry-mac"
  else
    pinentry_program="pinentry-program /usr/local/bin/pinentry-mac"
  fi

  if [ ! -f ~/.gnupg/gpg-agent.conf ] || ! grep -qxF "$pinentry_program" ~/.gnupg/gpg-agent.conf; then
    echo "$pinentry_program" >> ~/.gnupg/gpg-agent.conf
  fi

  killall gpg-agent >/dev/null 2>&1 || true
fi
