# frozen_string_literal: true

module FactoryHelper
  def generate_str(pattern)
    Regexp.new(pattern.sub('+', "{#{Word::MAX_LENGTH}}")).generate
  end

  def generate_str_different_from(str)
    str.chars.map(&:next).join[0...Word::MAX_LENGTH]
  end
end
