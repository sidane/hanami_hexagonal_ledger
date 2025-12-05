module BudgetLedger
  module Domain
    module Errors
      class AccountNotFound < StandardError; end
      class InsufficientFunds < StandardError; end
    end
  end
end
