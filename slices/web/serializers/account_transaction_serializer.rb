module Web
  module Serializers
    class AccountTransactionSerializer
      def self.serialize(account:, transaction:)
        {
          account: {
            id: account.id,
            name: account.name,
            balance: account.balance.to_s,
            currency: account.balance.currency
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
