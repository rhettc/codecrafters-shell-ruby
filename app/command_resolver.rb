# frozen_string_literal: true

class CommandResolver

  BUILTIN_COMMANDS = %w[exit echo type]
  BUILTIN_LOOKUP = {
    exit: :ExitCommand,
    echo: :EchoCommand,
    type: :TypeCommand

  }

  def initialize(name)
    @name = name
  end

  def resolve
    command = nil

    if is_builtin?(@name)
      command_class_name = BUILTIN_LOOKUP[@name.to_sym]
      command_class = Object.const_get(command_class_name)
      command = command_class.new(@name)
    elsif (location = find_executable(@name))
      command = ExecutableCommand.new(@name, location)
    end

    return command unless command.nil?

    raise UnrecognizedCommandError.new(@name)
  end

  def find_executable(name)
    sources = ENV['PATH'].split(File::PATH_SEPARATOR)
    sources.find { |path| File.executable?(File.join(path, name)) }
  end

  def is_builtin?(input)
    BUILTIN_COMMANDS.include?(input)
  end
end

