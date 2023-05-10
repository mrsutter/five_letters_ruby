# frozen_string_literal: true

module UserServices
  module Update
    class Container < BaseContainer
      namespace 'operations' do
        register('save') { UserServices::Update::Operations::Save.new }
      end
    end
  end
end
