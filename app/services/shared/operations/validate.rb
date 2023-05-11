# frozen_string_literal: true

module Shared
  module Operations
    class Validate < BaseOperation
      attr_reader :input

      def call(input)
        @input = input

        result = contract.call(input[:params])
        return Success(input) if result.success?

        error_details = processed_errors(result.errors)
        Failure(ServiceError.new(details: error_details))
      end

      private

      def contract
        input[:service].module_parent::Contract.new(data: input.except(:params))
      end

      def processed_errors(result_errors)
        result_errors.to_h.to_a.map do |error|
          field = error[0]
          first_code = error[1][0]
          { field: field, code: first_code }
        end
      end
    end
  end
end
