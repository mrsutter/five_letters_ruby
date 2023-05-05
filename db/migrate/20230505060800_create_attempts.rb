# frozen_string_literal: true

class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts, id: :uuid do |t|
      t.integer :number, null: false
      t.string :word, null: false
      t.string :result, array: true, null: false
      t.references :game, type: :uuid, null: false, foreign_key: true

      t.timestamps
      t.index %i[game_id number], unique: true
    end
  end
end
