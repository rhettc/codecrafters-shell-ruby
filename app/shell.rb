# frozen_string_literal: true
require 'fileutils'
require_relative 'input'
require_relative 'output'

class Shell

  def repl
    begin
      input = Input.new(read)
      next if input.empty?

      output = evaluate(input)
      exit_shell = output.signal == :exit
      print(output, input.output_redirection, input.error_redirection) unless output.silent?

    end until exit_shell
  end

  private

  def read
    $stdout.print("$ ")
    gets.chomp
  end

  def evaluate(input)
    begin
      command = CommandResolver.new(input.command_name).resolve
      puts "executing #{command.name} with args #{input.args} " if ENV['DEBUG']
      command.execute(input.args)
    rescue UnrecognizedCommandError => e
      Output.new(nil, nil, e.message)
    end
  end

  def print(output, output_redirection, error_redirection)
    if output_redirection || error_redirection
      write_to_file(output.value, output_redirection.target)
      Kernel.print "#{output.error}" unless output.error.nil?
    else
      puts "#{output.value}" if output.value_present?
      Kernel.print "#{output.error}" unless output.error.nil?
    end
  end
  def write_to_file(output, target)
    dir = File.dirname(target)
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    File.open(target, 'a') do |f|
      f.puts output
    end
  end

end
