# frozen_string_literal: true

module GameServices
  module Create
    module Operations
      class ChooseWord < BaseOperation
        attr_reader :user

        def call(input)
          @user = input[:user]

          game_word = new_word
          game_word ||= known_word

          input[:game_word] = game_word
          Success(input)
        end

        private

        def new_word
          known_word_ids = user.games.pluck(:word_id)

          user.language.words.available
              .where.not(id: known_word_ids)
              .order('RANDOM()')
              .first
        end

        def known_word
          user.language.words.available.order('RANDOM()').first
        end
      end
    end
  end
end
