# frozen_string_literal: true

# Watches the Ubuntu default /tmp library for cron task related changes
module Watcher
  def self.watch
    puts "\nWatching for crontab changes..."
    # New cron tasks are generated with names like "crontab.2IFp9l",
    # So anything that starts with cron is a task
    `cd /tmp; watch -t -g 'ls -l | grep crontab.'`
  end

  def self.alert(new_tasks)
    puts "\nWarning! one or several new cron tasks have been added!"
    puts 'Check the following new cron tasks, and remove them if they seem suspicious:'
    new_tasks.each { |task| puts task }
  end
end
