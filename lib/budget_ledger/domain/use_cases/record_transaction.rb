require_relative "../entities/account"
require_relative "../entities/transaction"
require_relative "../value_objects/money"
require_relative "../errors"

module BudgetLedger
  module Domain
    module UseCases
      class RecordTransaction
        def initialize(account_repository:, transaction_repository:, clock: -> { Time.now })
          @account_repository = account_repository
          @transaction_repository = transaction_repository
          @clock = clock
        end

        def call(account_id:, amount:, type:, currency: "GBP", description: nil)
          account = account_repository.find(account_id)

          unless account
            raise Errors::AccountNotFound.new(
              "Account with ID #{account_id} not found"
            )
          end

          amount_as_money = ValueObjects::Money.new(amount, currency:)

          transaction = Entities::Transaction.new(
            id: nil,
            account_id: account.id,
            amount: amount_as_money,
            type:,
            timestamp: clock.call,
            description:
          )

          updated_account = account.apply_transaction(transaction)

          if updated_account.balance.negative?
            raise Errors::InsufficientFunds.new(
              "Transaction would result in negative balance"
            )
          end

          persisted_transaction = transaction_repository.create(transaction)
          persisted_account = account_repository.update(updated_account)

          [persisted_account, persisted_transaction]
        end

        private

        attr_reader :account_repository, :transaction_repository, :clock
      end
    end
  end
end
