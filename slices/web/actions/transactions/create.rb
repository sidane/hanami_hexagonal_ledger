# frozen_string_literal: true

# Inbound Adapter
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
          unless request.params.valid?
            return json_response(response:, status: 422) do
              {errors: request.params.errors.to_h}
            end
          end

          account_id = request.params[:account_id]
          input = request.params[:transaction]

          updated_account, transaction = record_transaction_service.call(
            account_id:,
            amount: input[:amount],
            type: input[:type],
            currency: input[:currency] || "GBP",
            description: input[:description]
          )

          json_response(response:, status: 201) do
            Serializers::AccountTransactionSerializer.serialize(
              account: updated_account,
              transaction:
            )
          end
        end
      end
    end
  end
end
