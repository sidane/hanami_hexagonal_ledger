require "budget_ledger/domain/use_cases/open_account"

module Ledger
  class OpenAccount
    include Deps["persistence.account_repository"]

    def call(name:, opening_balance:, currency:)
      use_case = BudgetLedger::Domain::UseCases::OpenAccount.new(
        account_repository:
      )

      use_case.call(
        name:,
        opening_balance:,
        currency:
      )
    end
  end
end
