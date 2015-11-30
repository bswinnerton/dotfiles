export PATH="./bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

case "$(uname -s)" in
  Darwin)
    export PATH="/usr/local/bin:$PATH"
    export PATH="/usr/local/heroku/bin:$PATH"
    ;;

  Linux)
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    ;;
esac
