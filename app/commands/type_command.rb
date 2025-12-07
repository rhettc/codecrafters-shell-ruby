# frozen_string_literal: true

class TypeCommand < BuiltinCommand
  def execute(args)
    command_name = args.first
    command = resolve(command_name)
    is_builtin = command.is_a?(BuiltinCommand)
    if is_builtin
      # should commands have a name and we query that instead of using the args?
      $stdout.puts "#{command.name} is a shell builtin"
    elsif command.is_a?(ExecutableCommand)
      $stdout.puts "#{command.name} is #{command.full_path}"
    end
  rescue UnrecognizedCommandError => e
    $stdout.puts e.message
  end

  def resolve(command_name)
     CommandResolver.new(command_name).resolve
  end
end
