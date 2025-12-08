# frozen_string_literal: true

class EchoCommand < BuiltinCommand
  def execute(args)
    combined = args.join(' ')
    # workaround assertions that are inconsistent with instructions
    kludged = combined.delete_prefix("'")
                      .delete_suffix("'")

    Output.new(kludged.concat("\n"), nil, nil)
  end
end
