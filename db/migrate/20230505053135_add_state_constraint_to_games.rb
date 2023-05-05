# frozen_string_literal: true

class AddStateConstraintToGames < ActiveRecord::Migration[7.0]
  def up
    execute "
      ALTER TABLE games
        ADD CONSTRAINT cr_games_state CHECK (state IN ('active', 'wasted', 'won'))
    "
  end

  def down
    execute 'ALTER TABLE games DROP CONSTRAINT cr_games_state'
  end
end
