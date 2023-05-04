# frozen_string_literal: true

class AddLengthConstraintToWords < ActiveRecord::Migration[7.0]
  def up
    execute '
      ALTER TABLE words
        ADD CONSTRAINT cr_words_name_length CHECK (length(name) = 5)
    '
  end

  def down
    execute 'ALTER TABLE words DROP CONSTRAINT cr_words_name_length'
  end
end
