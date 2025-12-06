require "securerandom"
require "budget_ledger/domain/ports/transaction_repository"
require "budget_ledger/domain/entities/transaction"

# Outbound Adapter
module Ledger
  module Persistence
    class TransactionRepository
      include BudgetLedger::Domain::Ports::TransactionRepository
      include Deps["relations.transactions"]

      def create(transaction)
        tuple = transactions.changeset(:create, {
          account_id: transaction.account_id,
          amount_cents: to_cents(transaction.amount),
          currency: transaction.amount.currency,
          type: transaction.type.to_s,
          timestamp: transaction.timestamp,
          description: transaction.description
        }).commit

        to_entity(tuple)
      end

      def for_account(account_id)
        transactions
          .where(account_id: account_id)
          .to_a
          .map { |tuple| to_entity(tuple) }
      end

      private

      def to_entity(tuple)
        BudgetLedger::Domain::Entities::Transaction.new(
          id: tuple[:id],
          account_id: tuple[:account_id],
          amount: BudgetLedger::Domain::ValueObjects::Money.new(
            from_cents(tuple[:amount_cents]),
            currency: tuple[:currency]
          ),
          type: tuple[:type].to_sym,
          timestamp: tuple[:timestamp],
          currency: tuple[:currency],
          description: tuple[:description]
        )
      end

      def to_cents(money)
        (money.amount * 100).to_i
      end

      def from_cents(cents)
        BigDecimal(cents, 0) / 100
      end
    end
  end
end
