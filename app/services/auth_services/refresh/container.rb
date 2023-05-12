# frozen_string_literal: true

module AuthServices
  module Refresh
    class Container < BaseContainer
      namespace 'operations' do
        register('process_token') do
          AuthServices::Refresh::Operations::ProcessToken.new
        end
        register('destroy_tokens') do
          AuthServices::Refresh::Operations::DestroyTokens.new
        end
      end
    end
  end
end
