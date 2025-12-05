# frozen_string_literal: true

class ExitCommand < BuiltinCommand
  def initialize()
  end

  def execute(args)
    args ||= [0]
    exit_code = args.first&.to_i || 0
    [exit_code, :exit]
  end
end