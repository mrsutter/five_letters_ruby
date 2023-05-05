# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :game

  validates :number,
            numericality: { only_integer: true, in: 1..Game::MAX_ATTEMPTS_COUNT }
  validates :number, uniqueness: { scope: :game }
  validates :word,
            presence: true,
            length: { is: Word::MAX_LENGTH }
  validates :result, presence: true
end
