# frozen_string_literal: true

module UserServices
  module Update
    class Service < BaseService
      step :validate, with: 'shared.validate'
      step :create, with: 'operations.save'
    end
  end
end
