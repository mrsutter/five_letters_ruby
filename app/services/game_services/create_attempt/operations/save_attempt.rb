# frozen_string_literal: true

module GameServices
  module CreateAttempt
    module Operations
      class SaveAttempt < BaseOperation
        def call(input)
          word = input[:params][:word].downcase
          game = input[:game]

          attempt = game.attempts.new(
            word: word, number: game.attempts_count + 1
          )
          attempt.calc_result

          attempt.save!

          input[:attempt] = attempt
          Success(input)
        end
      end
    end
  end
end
