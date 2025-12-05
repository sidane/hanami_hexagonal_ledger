# frozen_string_literal: true

module Web
  module Actions
    module Accounts
      class Show < Web::Action
        include Deps[
          "ledger.services.get_account_details_service"
        ]

        handle_exception(
          "BudgetLedger::Domain::Errors::AccountNotFound" => :handle_account_not_found
        )

        def handle(request, response)
          details = get_account_details_service.call(
            account_id: request.params[:id]
          )

          json_response(response:, status: 200) do
            Serializers::AccountDetailsSerializer.serialize(details)
          end
        end

        private

        def handle_account_not_found(request, response, exception)
          json_response(response:, status: 404) do
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
  end
end
