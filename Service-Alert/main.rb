puts "\nWatching for new services..."
# new services that are ran on system start are stored in /etc/init.d
require 'rb-inotify'
notifier = INotify::Notifier.new
notifier.watch('/etc/init.d', :create) do |event|
  puts "\nService '#{event.name}' has been added!"
  puts "Make sure you've intentionally added '#{event.name}' or delete it\n"
end
notifier.run
