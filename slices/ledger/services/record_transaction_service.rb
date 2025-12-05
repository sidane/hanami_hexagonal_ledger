require "budget_ledger/domain/use_cases/record_transaction"
require "budget_ledger/domain/use_cases/open_account"

module Ledger
  module Services
    class RecordTransactionService
      include Deps[
        "persistence.account_repository",
        "persistence.transaction_repository"
      ]

      def call(account_id:, amount:, type:, currency: "GBP", description: nil)
        account = BudgetLedger::Domain::UseCases::OpenAccount.new(
          account_repository:
        ).call(
          name: "Joe Bloggs",
          opening_balance: 1000,
          currency: "GBP"
        )
        use_case = BudgetLedger::Domain::UseCases::RecordTransaction.new(
          account_repository:,
          transaction_repository:
        )

        use_case.call(
          account_id: account.id,
          amount:,
          type:,
          currency:,
          description:
        )
      end
    end
  end
end
