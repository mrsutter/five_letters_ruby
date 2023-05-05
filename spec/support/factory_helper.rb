# frozen_string_literal: true

module FactoryHelper
  def generate_str(pattern)
    Regexp.new(pattern.sub('+', "{#{Word::MAX_LENGTH}}")).generate
  end
end
