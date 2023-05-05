# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.datetime :game_available_at, null: false
      t.references :language, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
