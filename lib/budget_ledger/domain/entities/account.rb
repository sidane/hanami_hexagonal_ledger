module BudgetLedger
  module Domain
    module Entities
      class Account
        attr_reader :id, :name, :balance

        def initialize(id:, name:, balance: ValueObjects::Money.new(0))
          @id = id
          @name = name
          @balance = balance
        end

        def apply_transaction(transaction)
          new_balance = balance + transaction.signed_amount
          self.class.new(id: id, name: name, balance: new_balance)
        end
      end
    end
  end
end
