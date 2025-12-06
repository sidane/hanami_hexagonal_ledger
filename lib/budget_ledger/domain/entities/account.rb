module BudgetLedger
  module Domain
    module Entities
      class Account
        attr_reader :id, :name, :balance, :currency

        def initialize(id:, name:, balance: ValueObjects::Money.new(0), currency: "GBP")
          @id = id
          @name = name
          @balance = balance
          @currency = currency
        end

        def apply_transaction(transaction)
          new_balance = balance + transaction.signed_amount
          self.class.new(id:, name:, balance: new_balance, currency:)
        end
      end
    end
  end
end
