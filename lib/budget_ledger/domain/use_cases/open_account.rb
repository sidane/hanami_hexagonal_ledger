require_relative "../entities/account"
require_relative "../value_objects/money"
require "bigdecimal"

module BudgetLedger
  module Domain
    module UseCases
      class OpenAccount
        def initialize(account_repository:)
          @account_repository = account_repository
        end

        def call(name:, opening_balance: 0, currency: "GBP")
          balance = ValueObjects::Money.new(opening_balance, currency:)
          account = Entities::Account.new(
            id: nil,
            name:,
            balance:
          )

          @account_repository.create(account)
        end

        private

        attr_reader :account_repository
      end
    end
  end
end
