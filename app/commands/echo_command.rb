# frozen_string_literal: true

class EchoCommand < BuiltinCommand
  def execute(args)
    puts args.join(' ')
    [nil, nil]
  end
end
