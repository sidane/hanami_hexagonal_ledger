require "budget_ledger/domain/use_cases/get_account_details"

module Ledger
  module Services
    class GetAccountDetailsService
      include Deps[
        "persistence.account_repository",
        "persistence.transaction_repository"
      ]

      def call(account_id:)
        BudgetLedger::Domain::UseCases::GetAccountDetails.new(
          account_repository:,
          transaction_repository:
        ).call(account_id:)
      end
    end
  end
end
