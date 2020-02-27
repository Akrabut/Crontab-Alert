# frozen_string_literal: true

# persists the currently scheduled cron tasks in a GDBM instance
class DBHandler
  def initialize
    require 'gdbm'
    @gdbm ||= GDBM.new('cron_tasks.db')
    persist_cron_tasks
  end

  # compares the tasks previously persisted against the new list of tasks
  def check_differences(current_tasks)
    # use a set for O(1) access
    require 'set'
    persisted_tasks = Set.new(@gdbm.keys) # access db only once
    new_tasks = current_tasks.filter { |task| !persisted_tasks.include?(task) }
    @gdbm.close
    new_tasks
  end

  private

  def persist_cron_tasks
    tasks = Parser.parse
    return if !tasks || tasks.is_a?(String) || tasks.empty?

    # the value is not needed
    tasks.each { |task| @gdbm[task] = '' }
  end
end
