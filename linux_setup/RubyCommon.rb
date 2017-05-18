# Common ruby functions
require 'os'
require 'colorize'

# To get all possible colour values print String.colors
#puts String.colors

# Error handling
def onError(errordescription)

  puts ("ERROR: " + errordescription).red
  exit 1
end

# Coloured output
def info(message)
  puts message.to_s.colorize(:light_blue)
end
def success(message)
  puts message.to_s.colorize(:light_green)
end
def warning(message)
  puts message.to_s.colorize(:light_yellow)
end
def error(message)
  puts message.to_s.colorize(:red)
end



# Platform detection, for library suffix
if OS.linux?

  BuildPlatform = "linux"
  
elsif OS.windows?
  
  BuildPlatform = "windows"
  
elsif OS.mac?
  # Shouldn't be any file names that are different
  BuildPlatform = "linux"
else
  abort "Unknown OS type"
end

# Runs a command and calls onError if it fails
def systemChecked(command)
  
  system command
  onError "Command '#{command}' failed" if $?.exitstatus > 0
  
end

# Cross-platform way of finding an executable in the $PATH.
#
#   which('ruby') #=> /usr/bin/ruby
# from: http://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
def which(cmd)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = File.join(path, "#{cmd}#{ext}")
      return exe if File.executable?(exe) && !File.directory?(exe)
    }
  end
  return nil
end


def askRunSudo(cmd)

  info "About to run '#{cmd}' as sudo. Be prepared to type sudo password"
  
  systemChecked(cmd)
  
end
