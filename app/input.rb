# frozen_string_literal: true

class Input
  attr_reader :command_name, :args, :output_file

  def initialize(raw_input)
    @raw_input = raw_input

    unless @raw_input.empty?
      @command_name, @args = @raw_input.split(' ', 2)
      if @args.nil?
        @args = []
      else
        puts "partitioning args #{@args.partition(/\d?>/)}"
        @args, _, redirection_target = @args.partition(/\d?>/) # redirecting stdout ONLY for now

        @output_file = redirection_target.strip unless redirection_target.empty?
      end

    end

  end

  def empty?
    @raw_input.empty?
  end

  def output_to_stdout?
    @output_file.nil?
  end


end
