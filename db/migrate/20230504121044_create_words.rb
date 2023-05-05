# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words, id: :uuid do |t|
      t.string :name, null: false, index: { unique: true }
      t.boolean :archived, null: false, default: false
      t.references :language, type: :uuid, null: false, foreign_key: true

      t.timestamps

      t.index %i[language_id archived]
      t.index :updated_at
    end
  end
end
