# frozen_string_literal: true

module FactoryHelper
  def generate_str(pattern)
    Regexp.new(pattern.sub('+', "{#{Word::LENGTH}}")).generate
  end

  def generate_str_different_from(str)
    str.chars.map(&:next).join[0...Word::LENGTH]
  end
end
