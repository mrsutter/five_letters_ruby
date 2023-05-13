# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_MIN_LENGTH = Rails.configuration.x.min_password_length

  has_secure_password

  belongs_to :language
  has_many :games, dependent: :restrict_with_exception

  has_many :access_tokens,
           class_name: 'Tokens::AccessToken',
           dependent: :destroy
  has_many :refresh_tokens,
           class_name: 'Tokens::RefreshToken',
           dependent: :destroy

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
