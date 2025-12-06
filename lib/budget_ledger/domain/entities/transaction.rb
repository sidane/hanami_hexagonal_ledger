module BudgetLedger
  module Domain
    module Entities
      class Transaction
        attr_reader :id, :account_id, :amount, :type, :timestamp, :currency,
          :description

        def initialize(id:, account_id:, amount:, type:, timestamp:, currency:, description: nil)
          @id = id
          @account_id = account_id
          @amount = amount # Money
          @type = type # :credit or :debit
          @timestamp = timestamp
          @currency = currency
          @description = description
        end

        def signed_amount
          case type.to_sym
          when :credit
            amount
          when :debit
            ValueObjects::Money.new(-amount.amount, currency: amount.currency)
          else
            raise "Unknown transaction type #{type}"
          end
        end
      end
    end
  end
end
