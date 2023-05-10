# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :game

  validates :number,
            numericality: { only_integer: true, in: 1..Game::MAX_ATTEMPTS_COUNT }
  validates :number, uniqueness: { scope: :game }
  validates :word,
            presence: true,
            length: { is: Word::LENGTH }
  validates :result, presence: true

  scope :ordered_by_number, -> { order(:number) }

  def calc_result
    unmatched_chars = {}
    result = []

    game.puzzled_word.chars.each_with_index do |char, idx|
      if char == word[idx]
        result[idx] = :match
        next
      end

      unmatched_chars[char] ||= []
      unmatched_chars[char] << idx
    end

    word.chars.each_with_index do |char, idx|
      next if result[idx]

      if unmatched_chars[char].blank?
        result[idx] = :absence
        next
      end

      result[idx] = :wrong_place
      unmatched_chars[char].shift
    end

    self.result = result
  end

  def successful?
    word == game.puzzled_word
  end
end
