# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games, id: :uuid do |t|
      t.integer :attempts_count, null: false, default: 0
      t.string :state, null: false, default: 'active'
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :word, type: :uuid, null: false, foreign_key: true
      t.timestamps
      t.index :user_id,
              name: :index_games_active_on_user_id,
              unique: true, where: "state = 'active'"
    end
  end
end
