# frozen_string_literal: true

module Web
  module Actions
    module Transactions
      class Create < Web::Action
        include Deps[
          "ledger.services.record_transaction_service"
        ]

        params do
          required(:account_id).filled(:string)
          required(:transaction).hash do
            required(:amount).filled(:float)
            required(:type).filled(:string)
            optional(:currency).filled(:string)
            optional(:description).maybe(:string)
          end
        end

        def handle(request, response)
          account_id = request.params[:account_id]

          unless request.params.valid?
            response.status = 422
            response.format = :json
            response.body = {errors: request.params.errors.to_h}.to_json
            return
          end

          input = request.params[:transaction]

          begin
            updated_account, transaction = record_transaction_service.call(
              account_id:,
              amount: input[:amount],
              type: input[:type],
              currency: input[:currency] || "GBP",
              description: input[:description]
            )
          rescue BudgetLedger::Domain::Errors::AccountNotFound => e
            response.status = 404
            response.format = :json
            response.body = {error: e.message}.to_json
            return
          rescue BudgetLedger::Domain::Errors::InsufficientFunds => e
            response.status = 422
            response.format = :json
            response.body = {error: e.message}.to_json
            return
          end

          response.status = 201
          response.format = :json
          response.body = {
            account: {
              id: updated_account.id,
              name: updated_account.name,
              balance: updated_account.balance.to_s,
              currency: updated_account.balance.currency
            },
            transaction: {
              id: transaction.id,
              account_id: transaction.account_id,
              amount: transaction.amount.to_s,
              currency: transaction.amount.currency,
              type: transaction.type,
              timestamp: transaction.timestamp,
              description: transaction.description
            }
          }.to_json
        end
      end
    end
  end
end
