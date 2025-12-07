# frozen_string_literal: true

class BuiltinCommand < BasicCommand
  attr_reader :name
  def initialize(name)
    @name = name
  end
end
