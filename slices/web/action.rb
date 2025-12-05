# auto_register: false
# frozen_string_literal: true

require "budget_ledger/domain/errors"

module Web
  class Action < HanamiHexagonalLedger::Action
    handle_exception(
      "BudgetLedger::Domain::Errors::InsufficientFunds" => :handle_insufficient_funds,
      "BudgetLedger::Domain::Errors::AccountNotFound" => :handle_account_not_found
    )

    private

    def handle_account_not_found(request, response, exception)
      json_response(response:, status: 404) do
        {error: exception.message}
      end
    end

    def handle_insufficient_funds(request, response, exception)
      json_response(response:, status: 422) do
        {error: exception.message}
      end
    end

    def json_response(response:, status:)
      response.status = status
      response.format = :json
      response.body = yield.to_json if block_given?
    end
  end
end
