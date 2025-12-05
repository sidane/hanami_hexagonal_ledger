module Web
  module Serializers
    class AccountDetailsSerializer
      def self.serialize(details)
        {
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
              timestamp: tx[:timestamp],
              description: tx[:description]
            }
          end
        }
      end
    end
  end
end
