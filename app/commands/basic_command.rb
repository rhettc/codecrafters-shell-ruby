# frozen_string_literal: true

class BasicCommand
  def execute(args = [])
    raise NotImplementedError
  end
end
