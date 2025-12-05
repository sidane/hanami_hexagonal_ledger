module BudgetLedger
  module Domain
    module Ports
      module AccountRepository
        def find(id)
          raise NotImplementedError
        end

        def create(account)
          raise NotImplementedError
        end

        def update(account)
          raise NotImplementedError
        end
      end
    end
  end
end
