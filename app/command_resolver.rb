# frozen_string_literal: true

class CommandResolver

  BUILTIN_COMMANDS = %w[exit echo type]
  BUILTIN_LOOKUP = {
    exit: :ExitCommand,
    echo: :EchoCommand,
    type: :TypeCommand

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

