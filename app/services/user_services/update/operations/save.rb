# frozen_string_literal: true

module UserServices
  module Update
    module Operations
      class Save < BaseOperation
        def call(input)
          language_id = input[:params][:language_id]

          result = input[:user].update(language_id: language_id)
          Success(result)
        end
      end
    end
  end
end
