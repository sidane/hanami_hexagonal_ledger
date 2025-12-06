require "budget_ledger/domain/use_cases/record_transaction"
require "budget_ledger/domain/use_cases/open_account"

# Inbound Orchestration
module Ledger
  module Services
    class RecordTransactionService
      include Deps[
        "persistence.account_repository",
        "persistence.transaction_repository"
      ]

      def call(account_id:, amount:, type:, currency: "GBP", description: nil)
        BudgetLedger::Domain::UseCases::RecordTransaction.new(
          account_repository:,
          transaction_repository:
        ).call(account_id:, amount:, type:, currency:, description:)
      end
    end
  end
end
