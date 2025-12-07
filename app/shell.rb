# frozen_string_literal: true

class Shell
  SIGNALS = %w[:term]
  def read
    $stdout.print("$ ")
    gets.chomp
  end

  def evaluate(input)
    return if input.nil?
    command, args = input.split(' ', 2)
    args = args.split(' ') unless args.nil?
    begin
      resolved_command = CommandResolver.new(command).resolve

      resolved_command.execute(args)

    rescue UnrecognizedCommandError => e
      $stderr.puts e.message
      return nil
    end
  end


  def repl
    begin
      input = read
      next if input.empty?

      output, signal = evaluate(input)
      next if output.nil?

      print "#{output}" if signal.nil?

      exit_shell = signal == :exit
    end until exit_shell
  end
end
