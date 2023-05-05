# frozen_string_literal: true

class AddWordLengthConstraintToAttempts < ActiveRecord::Migration[7.0]
  def up
    execute '
      ALTER TABLE attempts
        ADD CONSTRAINT cr_attempts_word_length CHECK (length(word) = 5)
    '
  end

  def down
    execute 'ALTER TABLE attempts DROP CONSTRAINT cr_attempts_word_length'
  end
end
