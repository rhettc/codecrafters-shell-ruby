# frozen_string_literal: true

class UnrecognizedCommandError < StandardError
  def initialize(command)
    @command = command
    super
  end
end


