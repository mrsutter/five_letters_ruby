# frozen_string_literal: true

class BaseService
  include Dry::Transaction

  def call(input)
    input[:service] = self.class
    input[:params] = input[:params].to_h
    super
  end

  class << self
    def inherited(klass)
      container = klass.module_parent::Container
      klass.public_send(:include, Dry::Transaction(container: container))
      super
    end
  end
end
