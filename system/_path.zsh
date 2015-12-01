case "$(uname -s)" in
  Darwin)
    export PATH="/usr/local/heroku/bin:$PATH"
    export PATH="/usr/local/bin:$PATH"
    ;;

  Linux)
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    ;;
esac

export PATH="./bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
