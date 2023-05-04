# frozen_string_literal: true

class Word < ApplicationRecord
  MAX_LENGTH = 5

  belongs_to :language

  validates :name,
            presence: true,
            uniqueness: true,
            length: { is: MAX_LENGTH }
  validate :name_should_match_language_letters, if: :language

  validates :archived, inclusion: [true, false]

  scope :available, -> { where(archived: false) }

  private

  def name_should_match_language_letters
    return if Regexp.new(language.letters).match?(name)

    errors.add(:name, :invalid)
  end
end
