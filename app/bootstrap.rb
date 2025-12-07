# frozen_string_literal: true

class Bootstrap
  class << self

    def load_dependencies
      require_relative 'command_resolver'
      require_relative 'errors/unrecognized_command_error'
      require_all_commands
    end

    def require_all_commands
      command_dir = File.join(File.dirname(__FILE__), 'commands')
      command_files = Dir.glob(File.join(command_dir, '*_command.rb'))

      command_files.each do |file|
        require File.expand_path(file)
      end
    end

  end

end
