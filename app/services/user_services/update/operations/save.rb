# frozen_string_literal: true

module UserServices
  module Update
    module Operations
      class Save < BaseOperation
        def call(input)
          language_id = input[:params][:language_id]

          input[:user].update(language_id: language_id)
          Success(input)
        end
      end
    end
  end
end
