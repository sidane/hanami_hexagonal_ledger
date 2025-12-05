# frozen_string_literal: true

require "budget_ledger/domain/use_cases/get_account_details"

module Web
  module Actions
    module Accounts
      class Show < Web::Action
        include Deps[
          "ledger.persistence.account_repository",
          "ledger.persistence.transaction_repository"
        ]

        def handle(request, response)
          account_details = BudgetLedger::Domain::UseCases::GetAccountDetails.new(
            account_repository:,
            transaction_repository:
          ).call(account_id: request.params[:id])

          json_response(response:, status: 200) do
            Serializers::AccountDetailsSerializer.serialize(account_details)
          end
        end

        private
      end
    end
  end
end
