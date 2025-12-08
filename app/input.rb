# frozen_string_literal: true
require_relative 'redirection'
class Input
  attr_reader :command_name, :args, :output_redirection, :error_redirection

  def initialize(raw_input)
    @raw_input = raw_input

    unless @raw_input.empty?
      @command_name, args = @raw_input.split(' ', 2)
      if args.nil?
        @args = []
      else
        parse_args(args)
      end
    end

  end

  def empty?
    @raw_input.empty?
  end

  def output_to_stdout?
    @output_file.nil?
  end

  def any_redirection?
    puts "any redirection? #{@output_redirection || @error_redirection}" if ENV['DEBUG']
    @output_redirection || @error_redirection
  end

  private
  def parse_args(args)
    puts "partitioning args #{args.partition(/\d?>/)}" if ENV['DEBUG']
    @args, _, redirection_target = args.partition(/\d?>/)
                                        .map(&:strip)

    @args = @args.split(' ')
    unless redirection_target.empty?
      @output_redirection = Redirection.new(:stdout, redirection_target)
    end

  end
end
