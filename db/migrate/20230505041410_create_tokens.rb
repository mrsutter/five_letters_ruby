# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens, id: :uuid do |t|
      t.string :jti, null: false, unique: true
      t.string :type, null: false

      t.datetime :expired_at, null: false

      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :refresh_token, type: :uuid, foreign_key: { to_table: :tokens }

      t.timestamps
    end
  end
end
