# frozen_string_literal: true
require 'open3'
class ExecutableCommand < BasicCommand
  attr_reader :name, :location
  def initialize(name, location)
    @name = name
    @location = location
  end

  def full_path
    File.join(location, name)
  end

  def execute(args = [])
    # debt: Serializing out/err to a string is not memory efficient in situations with large out/err
    stdout, stderr, status = Open3.capture3(name, *args)
    stdout
   end
end
