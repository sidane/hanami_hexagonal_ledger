require "securerandom"
require "budget_ledger/domain/ports/account_repository"
require "budget_ledger/domain/entities/account"

module Ledger
  module Persistence
    class AccountRepository
      include BudgetLedger::Domain::Ports::AccountRepository

      def initialize
        @store = {}
      end

      def find(id)
        @store[id]
      end

      # Outbound port implementation
      def create(account)
        id = SecureRandom.uuid
        stored = BudgetLedger::Domain::Entities::Account.new(
          id:,
          name: account.name,
          balance: account.balance
        )

        @store[id] = stored
        stored
      end

      def update(account)
        return nil unless @store.key?(account.id)

        @store[account.id] = account
        account
      end
    end
  end
end
