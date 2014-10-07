require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  install_oh_my_zsh
  switch_to_zsh
  install_brew
  install_brew_packages
  replace_all = false
  files = Dir['*'] - %w( Rakefile README.md oh-my-zsh tmux-powerline PowerlineSymbols.otf Brewfile )
  files << 'oh-my-zsh/custom/bswinnerton.zsh-theme'
  files << 'vim/bundle/'
  files.each do |file|
    %x( mkdir -p "$HOME/.#{File.dirname(file)}" ) if file =~ /\//
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        puts "overwrite ~/.#{file.sub(/\.erb$/, '')}? [Ynaq]"
        case STDIN.gets.strip
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
  if RUBY_PLATFORM =~ /darwin/
    #%x( $HOME/.dotfiles/osx/init.sh )
  end
end

def replace_file(file)
  %x( rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}" )
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
    %x( cp "$PWD/#{file}" "$HOME/.#{file}" )
  else
    puts "linking ~/.#{file}"
    %x( ln -s "$PWD/#{file}" "$HOME/.#{file}" )
  end
end

def switch_to_zsh
  if ENV['SHELL'] =~ /zsh/
    puts 'using zsh'
  else
    puts 'switch to zsh? (recommended) [Ynq]'
    case STDIN.gets.strip
    when '', 'y', 'Y'
      puts 'switching to zsh'
      %x( chsh -s `which zsh` )
    when 'q'
      exit
    else
      puts 'skipping zsh'
    end
  end
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], '.oh-my-zsh'))
    puts 'found ~/.oh-my-zsh'
  else
    puts 'install oh-my-zsh? [Ynq]'
    case STDIN.gets.chomp
    when '', 'y', 'Y'
      if RUBY_PLATFORM =~ /darwin/
        puts 'installing oh-my-zsh'
        %x( git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" )
      else
        puts 'installing oh-my-zsh'
        %x( sudo apt-get install zsh )
        %x( curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh )
      end
    when 'q'
      exit
    else
      puts 'skipping oh-my-zsh, you will need to change ~/.zshrc'
    end
  end
end

def install_brew
  if RUBY_PLATFORM =~ /darwin/
    if `which brew`.empty?
      %x( curl -fsSL https://raw.github.com/mxcl/homebrew/go )
    else
      puts 'Brew is already installed. Fix permissions? (yNq)'
      case STDIN.gets.strip
      when 'y', 'Y'
        %x( sudo chmod -R g+rwx /usr/local/ )
        %x( sudo chmod -R g+rwx /Library/Caches/Homebrew/ )
      when 'q'
        exit
      else
      end
    end
  end
end

def install_brew_packages
  if RUBY_PLATFORM =~ /darwin/
    %x( brew bundle )
  end
end
