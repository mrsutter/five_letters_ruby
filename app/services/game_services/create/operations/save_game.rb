# frozen_string_literal: true

module GameServices
  module Create
    module Operations
      class SaveGame < BaseOperation
        def call(input)
          input[:game] = input[:user].games.create!(word: input[:game_word])
          Success(input)
        end
      end
    end
  end
end
