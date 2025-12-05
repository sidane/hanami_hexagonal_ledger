module Web
  module Serializers
    class AccountSerializer
      def self.serialize(account)
        {
          id: account.id,
          name: account.name,
          balance: {
            amount: account.balance.amount.to_f,
            currency: account.balance.currency
          }
        }
      end
    end
  end
end
