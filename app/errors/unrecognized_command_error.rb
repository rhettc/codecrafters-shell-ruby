# frozen_string_literal: true

class UnrecognizedCommandError < StandardError
  def initialize(command)
    @command = command
    super
  end
  def message
    "#{@command}: not found\n"
  end
end


