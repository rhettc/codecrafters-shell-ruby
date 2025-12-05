require_relative 'command_resolver'

require_relative 'errors/unrecognized_command_error'

SIGNALS = %w[:term]

def read
  $stdout.print("$ ")
  #$stdout.flush
  gets.chomp
end

def evaluate(input)
  return if input.nil?
  command, args = input.split

  begin
    resolved_command = CommandResolver.new(command).resolve

    resolved_command.execute(args)

  rescue UnrecognizedCommandError
    $stderr.puts "#{command}: not found"
    return nil
  end
end

def repl
  begin
    input = read
    next if input.empty?

    output, signal = evaluate(input)
    next if output.nil?

    print "#{output}\n" if signal.nil?

    exit_shell = signal == :exit
  end until exit_shell
end

repl