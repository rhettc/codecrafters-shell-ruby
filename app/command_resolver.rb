# frozen_string_literal: true

require_relative 'errors/unrecognized_command_error'
require_relative 'commands/basic_command'
require_relative 'commands/builtin_command'
require_relative 'commands/exit_command'

class CommandResolver

  BUILTIN_COMMANDS = %w[exit]
  BUILTIN_LOOKUP = {
    exit: :ExitCommand
  }
  def initialize(input)
    @input = input
  end

  def resolve
    unless command_exists?(@input)
      raise UnrecognizedCommandError.new(@input)
    end

    command_class_name = BUILTIN_LOOKUP[@input.to_sym]
    command_class = Object.const_get(command_class_name)
    command_class.new

  end

  def command_exists?(input)
    BUILTIN_COMMANDS.include?(input)
  end
end

