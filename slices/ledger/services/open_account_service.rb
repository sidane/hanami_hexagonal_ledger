require "budget_ledger/domain/use_cases/open_account"

module Ledger
  module Services
    class OpenAccountService
      include Deps["persistence.account_repository"]

      def call(name:, opening_balance:, currency:)
        BudgetLedger::Domain::UseCases::OpenAccount.new(
          account_repository:
        ).call(name:, opening_balance:, currency:)
      end
    end
  end
end
