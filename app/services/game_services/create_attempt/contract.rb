# frozen_string_literal: true

module GameServices
  module CreateAttempt
    class Contract < BaseContract
      params do
        required(:word).filled(:string)
      end

      rule(:word) do
        game = data[:game]
        game_word = game.word

        word = Word.find_by(name: value.downcase, language: game_word.language)
        key.failure('not_found') if word.blank? || word.archived && (word != game.puzzled_word)
      end
    end
  end
end
