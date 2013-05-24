require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  install_oh_my_zsh
  switch_to_zsh
  replace_all = false
  files = Dir['*'] - %w[Rakefile readme.md oh-my-zsh tmux-powerline PowerlineSymbols.otf]
  files << "oh-my-zsh/custom/bswinnerton.zsh-theme"
  files << "vim/bundle/"
  files.each do |file|
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [Ynaq] "
        case $stdin.gets.chomp
        when ''
          replace_file(file)
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
  download_git_submodules
  # TODO:
  #install_brew
  #install_rbenv
  #install_tmux
  #fix_copy_and_paste
  if RUBY_PLATFORM =~ /darwin/
    system %Q{$HOME/.dotfiles/osx/init.sh}
  end
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  elsif file =~ /zshrc$/ # copy zshrc instead of link
    puts "copying ~/.#{file}"
    system %Q{cp "$PWD/#{file}" "$HOME/.#{file}"}
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [Ynq] "
    case $stdin.gets.chomp
    when ''
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [Ynq] "
    case $stdin.gets.chomp
    when ''
      if RUBY_PLATFORM =~ /darwin/
        puts "installing oh-my-zsh"
        system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
      else
        puts "installing oh-my-zsh"
        system %Q{sudo apt-get install zsh}
        system %Q{curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh}
      end
    when 'y'
      if RUBY_PLATFORM =~ /darwin/
        puts "installing oh-my-zsh"
        system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
      else
        puts "installing oh-my-zsh"
        system %Q{sudo apt-get install zsh}
        system %Q{curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh}
      end
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end

def download_git_submodules
  %x( cd ~/.dotfiles/ && git submodule init && git submodule update )
end

def install_brew
  if RUBY_PLATFORM =~ /darwin/
    %x( curl -fsSL https://raw.github.com/mxcl/homebrew/go )
  end
end

def fix_copy_and_paste
  if RUBY_PLATFORM =~ /darwin/
    %x( brew install reattach-to-user-namespace )
  end
end
