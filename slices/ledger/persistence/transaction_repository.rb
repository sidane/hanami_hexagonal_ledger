require "securerandom"
require "budget_ledger/domain/ports/transaction_repository"
require "budget_ledger/domain/entities/transaction"

module Ledger
  module Persistence
    class TransactionRepository
      include BudgetLedger::Domain::Ports::TransactionRepository

      def initialize
        @store = {}
      end

      # Outbound port implementation
      def create(account)
        id = SecureRandom.uuid
        stored = BudgetLedger::Domain::Entities::Transaction.new(
          id:,
          account_id: transaction.account_id,
          amount: transaction.amount,
          type: transaction.type,
          timestamp: transaction.timestamp,
          description: transaction.description
        )

        @store[id] = stored
        stored
      end

      def for_account(account_id)
        @store.values.select { |t| t.account_id == account_id }
      end
    end
  end
end
