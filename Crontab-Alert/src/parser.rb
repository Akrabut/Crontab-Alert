# frozen_string_literal: true

# Parses the crontab -l standard output to contain only the tasks
module Parser
  def self.parse
    # Tasks are in the format of * * * * * name_of_script where * can be integers
    # the file contains lots of bloat about how tasks should be created, this filters it
    `crontab -l`.split("\n").filter { |line| !line.start_with?('#') }
  end
end
