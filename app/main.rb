require_relative 'command_resolver'
require_relative 'errors/unrecognized_command_error'

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
    output = resolved_command.execute(args)
  rescue UnrecognizedCommandError
    $stderr.puts "#{command}: not found"
    return nil
  end

end

def repl
  begin
    input = read
    next if input.empty?

    output = evaluate(input)
    print "#{output}\n" if output
  end while true
end

repl