# frozen_string_literal: true

class Game < ApplicationRecord
  include AASM

  LIFECYCLE_HOURS = Rails.configuration.x.game_lifecycle_hours
  MAX_ATTEMPTS_COUNT = Rails.configuration.x.game_max_attempts_count

  belongs_to :user
  belongs_to :word
  has_many :attempts

  validates :attempts_count,
            numericality: { only_integer: true, in: 0..MAX_ATTEMPTS_COUNT }
  validates :user, uniqueness: true, if: -> { active? }

  aasm column: :state do
    state :active, initial: true
    state :won
    state :wasted

    event :win do
      transitions from: :active, to: :won
    end

    event :waste do
      transitions from: :active, to: :wasted
    end
  end
end
