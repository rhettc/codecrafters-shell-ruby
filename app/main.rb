require_relative 'command_resolver'
require_relative 'errors/unrecognized_command_error'

$stdout.write("$ ")
input = gets.chomp
exit 0 if input.nil?
command, args = input.split

begin
  resolved_command = CommandResolver.new(command).resolve
rescue UnrecognizedCommandError
  $stderr.write "#{command}: not found"
end