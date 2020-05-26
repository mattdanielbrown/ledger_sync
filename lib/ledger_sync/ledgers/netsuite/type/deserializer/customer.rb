# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Type
        module Deserializer
          class Customer < LedgerSync::Type::Value
            def initialize(args = {})
              @customer_class = args.fetch(:customer_class)
            end

            private

            def cast_value(args = {})
              value = args.fetch(:value)

              return if value.nil?

              @customer_class.new(
                ledger_id: value.fetch('id', nil)
              )
            end

            def valid_classes
              [
                Hash
              ]
            end
          end
        end
      end
    end
  end
end
