if test (uname) = Darwin
  for prefix in /opt/homebrew /usr/local
    if test -x $prefix/bin/brew
      fish_add_path $prefix/bin $prefix/sbin
      break
    end
  end
end
