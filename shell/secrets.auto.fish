if test -f ~/.env
    for line in (grep -v '^#' ~/.env | grep -v '^\s*$')
        set -l key (string split -m1 '=' -- $line)[1]
        set -l val (string split -m1 '=' -- $line)[2]
        set -gx $key $val
    end
end
