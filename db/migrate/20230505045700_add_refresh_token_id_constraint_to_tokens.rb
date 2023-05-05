# frozen_string_literal: true

class AddRefreshTokenIdConstraintToTokens < ActiveRecord::Migration[7.0]
  def up
    execute "
      ALTER TABLE tokens
        ADD CONSTRAINT cr_tokens_refresh_token_presence
        CHECK (NOT (type = 'Tokens::AccessToken' AND refresh_token_id IS NULL));
    "
  end

  def down
    execute 'ALTER TABLE tokens DROP CONSTRAINT cr_tokens_refresh_token_presence'
  end
end
