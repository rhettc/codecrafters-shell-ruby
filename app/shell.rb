# frozen_string_literal: true
require 'fileutils'
require_relative 'input'
class Shell
  SIGNALS = %w[:term]
  def read
    $stdout.print("$ ")
    gets.chomp
  end

  def evaluate(input)
    begin
      command = CommandResolver.new(input.command_name).resolve
      puts "executing #{command.name} with args #{input.args} "
      command.execute(input.args)

    rescue UnrecognizedCommandError => e
      $stderr.puts e.message
      return nil
    end
  end

  def repl
    begin
      input = Input.new(read)
      next if input.empty?

      output, signal = evaluate(input)
      next if output.nil?

      if input.output_to_stdout?
        puts "output is #{output}"
        print "#{output}" if signal.nil?
      else
        puts "output is #{output}"
        write_to_file(output, input.output_file)
      end

      exit_shell = signal == :exit
    end until exit_shell
  end

  private

  def write_to_file(output, target)
    puts "writing #{output} to #{target}"
    dir = File.dirname(target)
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    File.open(target, 'a') { |f| f.print output }
  end
end
