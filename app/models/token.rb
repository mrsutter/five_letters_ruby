# frozen_string_literal: true

class Token < ApplicationRecord
  belongs_to :user

  validates :type, presence: true
  validates :expired_at, presence: true
  validates :jti, presence: true, uniqueness: true

  attribute :value, :string

  scope :expired, -> { where('expired_at < ?', Time.current) }
end
