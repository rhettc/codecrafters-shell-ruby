# frozen_string_literal: true

class ExecutableCommand < BasicCommand
  attr_reader :name, :location
  def initialize(name, location)
    @name = name
    @location = location
  end

  def full_path
    File.join(location, name)
  end
end
