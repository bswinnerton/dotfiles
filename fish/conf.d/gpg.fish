# Cache GPG passphrase on first interactive login so that non-interactive
# processes (like Claude Code) can sign commits without a TTY.
if status is-interactive
    set -l keygrip (gpg --list-secret-keys --with-keygrip --with-colons 2>/dev/null | grep '^grp' | head -1 | cut -d: -f10)

    if test -n "$keygrip"
        set -l keyinfo (gpg-connect-agent "keyinfo $keygrip" /bye 2>/dev/null)

        if not string match -q "* 1 *" -- $keyinfo
            echo "GPG passphrase not cached. Please enter it to enable commit signing."
            read -s -P "GPG Passphrase: " passphrase
            echo $passphrase | /usr/lib/gnupg/gpg-preset-passphrase --preset $keygrip
            set -e passphrase
            echo ""

            # Verify it worked
            set -l keyinfo (gpg-connect-agent "keyinfo $keygrip" /bye 2>/dev/null)
            if string match -q "* 1 *" -- $keyinfo
                echo "GPG passphrase cached successfully."
            else
                echo "Warning: GPG passphrase caching may have failed."
            end
        end
    end
end
