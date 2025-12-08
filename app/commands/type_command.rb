# frozen_string_literal: true

class TypeCommand < BuiltinCommand
  def execute(args)
    command_name = args.first
    value = nil
    begin
      command = resolve(command_name)
      is_builtin = command.is_a?(BuiltinCommand)
      if is_builtin
        value = "#{command.name} is a shell builtin"
      elsif command.is_a?(ExecutableCommand)
        value = "#{command.name} is #{command.full_path}"
      end
    rescue UnrecognizedCommandError => e
      value = e.message
    end
    Output.new(value, nil, nil)
  end

  def resolve(command_name)
    CommandResolver.new(command_name).resolve
  end
end
