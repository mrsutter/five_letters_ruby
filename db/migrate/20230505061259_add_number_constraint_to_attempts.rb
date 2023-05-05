# frozen_string_literal: true

class AddNumberConstraintToAttempts < ActiveRecord::Migration[7.0]
  def up
    execute '
      ALTER TABLE attempts
        ADD CONSTRAINT cr_attempts_number CHECK (number >= 1 AND number <= 6)
    '
  end

  def down
    execute 'ALTER TABLE attempts DROP CONSTRAINT cr_attempts_number'
  end
end
