require_relative "../errors"

# Inbound Port
module BudgetLedger
  module Domain
    module UseCases
      class GetAccountDetails
        def initialize(account_repository:, transaction_repository:)
          @account_repository = account_repository
          @transaction_repository = transaction_repository
        end

        def call(account_id:)
          account = @account_repository.find(account_id)
          raise_if_account_not_found(account)

          transactions = @transaction_repository.for_account(account_id)
          {
            account: {
              id: account.id,
              name: account.name,
              balance: account.balance,
              currency: account.currency
            },
            transactions: transactions.sort_by(&:timestamp).map do |tx|
              {
                id: tx.id,
                amount: tx.amount.to_s,
                currency: tx.currency,
                type: tx.type,
                timestamp: tx.timestamp,
                description: tx.description
              }
            end
          }
        end

        private

        attr_reader :account_repository, :transaction_repository

        def raise_if_account_not_found(account)
          unless account
            raise(
              Errors::AccountNotFound,
              "Account with ID #{account_id} not found"
            )
          end
        end
      end
    end
  end
end
