# frozen_string_literal: true

class Output
  attr_reader :value, :signal, :error, :exit_code
  def initialize(value, signal, error, exit_code = nil)
    @value = value
    @signal = signal
    @error = error
    @exit_code = exit_code
  end

  def silent?
    !signal.nil?
  end

  def value_present?
    !value.nil?
  end
end
