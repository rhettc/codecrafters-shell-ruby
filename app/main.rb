
SIGNALS = %w[:term]

def load_dependencies
  require_relative 'command_resolver'
  require_relative 'errors/unrecognized_command_error'
  require_all_commands
end

def require_all_commands
  Dir.glob(File.join(File.dirname(__FILE__), 'commands', '*_command.rb')).each do |file|
    require file
  end
end

def read
  $stdout.print("$ ")
  #$stdout.flush
  gets.chomp
end

def evaluate(input)
  return if input.nil?
  command, args = input.split(' ', 2)
  args = args.split(' ') unless args.nil?
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

load_dependencies
repl