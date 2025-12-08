# frozen_string_literal: true

class Redirection
  SOURCES = %i[stdout stderr]
  attr_reader :source, :target
  def initialize(source, target)
    enforce_valid_source(source)
    @source = source
    @target = target
  end

  private
  def enforce_valid_source(source)
    raise ArgumentError, "Invalid redirection source #{source}" unless SOURCES.include?(source)
  end

end
