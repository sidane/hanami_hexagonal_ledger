require "securerandom"
require "budget_ledger/domain/ports/account_repository"
require "budget_ledger/domain/entities/account"
require "budget_ledger/domain/value_objects/money"

module Ledger
  module Persistence
    class AccountRepository
      include BudgetLedger::Domain::Ports::AccountRepository
      include Deps["relations.accounts"]

      def find(id)
        tuple = accounts.by_pk(id).one
        tuple && to_entity(tuple)
      end

      def create(account)
        now = Time.now

        tuple = accounts.changeset(:create, {
          name: account.name,
          balance_cents: to_cents(account.balance),
          currency: account.balance.currency,
          created_at: now,
          updated_at: now
        }).commit

        to_entity(tuple)
      end

      def update(account)
        now = Time.now

        accounts.by_pk(account.id).changeset(:update, {
          name: account.name,
          balance_cents: to_cents(account.balance),
          currency: account.balance.currency,
          updated_at: now
        }).commit

        tuple = accounts.by_pk(account.id).one
        to_entity(tuple)
      end

      private

      def to_entity(tuple)
        BudgetLedger::Domain::Entities::Account.new(
          id: tuple[:id],
          name: tuple[:name],
          balance: BudgetLedger::Domain::ValueObjects::Money.new(
            from_cents(tuple[:balance_cents]),
            currency: tuple[:currency]
          )
        )
      end

      def to_cents(money)
        # money.amount is BigDecimal
        (money.amount * 100).to_i
      end

      def from_cents(cents)
        BigDecimal(cents, 0) / 100
      end
    end
  end
end
