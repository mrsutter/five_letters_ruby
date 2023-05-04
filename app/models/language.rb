# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :words

  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true
  validates :letters, presence: true
  validates :available, inclusion: [true, false]

  scope :available, -> { where(available: true) }
  scope :ordered, -> { order(:created_at) }
end
