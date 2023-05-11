# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_MIN_LENGTH = Rails.configuration.x.min_password_length

  has_secure_password

  belongs_to :language
  has_many :games

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: Rails.configuration.x.email_regex }
  validates :game_available_at, presence: true
  validates :password,
            presence: true,
            length: { minimum: PASSWORD_MIN_LENGTH },
            on: :create
end
