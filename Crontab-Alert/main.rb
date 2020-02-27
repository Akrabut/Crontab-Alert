# frozen_string_literal: true

# constantly listen for task creation and alert when a new one is created
loop do
  require_relative 'src/require_helper'
  db_handler = DBHandler.new
  Watcher.watch
  new_tasks = db_handler.check_differences(Parser.parse)
  Watcher.alert(new_tasks) unless new_tasks.nil? || new_tasks.empty?
end
