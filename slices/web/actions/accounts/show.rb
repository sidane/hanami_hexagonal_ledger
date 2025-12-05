# frozen_string_literal: true

module Web
  module Actions
    module Accounts
      class Show < Web::Action
        include Deps[
          "ledger.services.get_account_details_service"
        ]

        def handle(request, response)
          account_id = request.params[:id]

          begin
            details = get_account_details_service.call(account_id: account_id)
          rescue BudgetLedger::Domain::Errors::AccountNotFound => e
            response.status = 404
            response.format = :json
            response.body = {error: e.message}.to_json
            return
          end

          response.status = 200
          response.format = :json
          response.body = {
            account: {
              id: details[:account][:id],
              name: details[:account][:name],
              balance: details[:account][:balance],
              currency: details[:account][:currency]
            },
            transactions: details[:transactions].map do |tx|
              {
                id: tx[:id],
                amount: tx[:amount],
                currency: tx[:currency],
                type: tx[:type],
                timestamp: tx[:date],
                description: tx[:description]
              }
            end
          }.to_json
        end
      end
    end
  end
end
