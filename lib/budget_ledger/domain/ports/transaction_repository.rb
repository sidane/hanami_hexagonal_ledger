module BudgetLedger
  module Domain
    module Ports
      module TransactionRepository
        def create(transaction)
          raise NotImplementedError
        end

        def for_account(account_id)
          raise NotImplementedError
        end
      end
    end
  end
end
