# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :languages, id: :uuid do |t|
      t.string :slug, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :letters, null: false
      t.boolean :available, null: false, default: true
      t.timestamps
    end
  end
end
