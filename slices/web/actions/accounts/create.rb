# frozen_string_literal: true

module Web
  module Actions
    module Accounts
      class Create < Web::Action
        include Deps["ledger.services.open_account_service"]

        params do
          required(:account).hash do
            required(:name).filled(:string)
            optional(:opening_balance).filled(:float)
            optional(:currency).filled(:string)
          end
        end

        def handle(request, response)
          unless request.params.valid?
            response.status = 422
            response.format = :json
            response.body = {errors: request.params.errors.to_h}.to_json
            return
          end

          account_params = request.params[:account]

          account = open_account_service.call(
            name: account_params[:name],
            opening_balance: account_params.fetch(:opening_balance, 0),
            currency: account_params.fetch(:currency, "GBP")
          )

          response.status = 201
          response.format = :json
          response.body = {
            id: account.id,
            name: account.name,
            balance: {
              amount: account.balance.amount.to_f,
              currency: account.balance.currency
            }
          }.to_json
        end
      end
    end
  end
end
