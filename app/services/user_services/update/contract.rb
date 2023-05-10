# frozen_string_literal: true

module UserServices
  module Update
    class Contract < BaseContract
      params do
        required(:language_id).filled(:string)
      end

      rule(:language_id) do
        key.failure('wrong') if Language.available.find_by(id: value).blank?
      end
    end
  end
end
