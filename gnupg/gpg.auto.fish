if not echo "test" | gpg --batch --pinentry-mode default --clearsign >/dev/null 2>&1
    echo "test" | gpg --clearsign >/dev/null
end
