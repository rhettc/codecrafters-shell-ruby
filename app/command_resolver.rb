# frozen_string_literal: true

require_relative 'errors/unrecognized_command_error'

class CommandResolver

  def initialize(input)
    @input = input
  end

  def resolve
    raise UnrecognizedCommandError.new(@input) unless command_exists?(@input)
  end

  def command_exists?(input)
    false
  end
end
