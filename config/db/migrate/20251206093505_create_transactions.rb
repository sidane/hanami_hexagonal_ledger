# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :transactions do
      primary_key :id
      foreign_key :account_id, :accounts, null: false, on_delete: :cascade
      column :amount_cents, Integer, null: false
      column :currency, String, null: false, default: "GBP"
      column :type, String, null: false
      column :timestamp, DateTime, null: false
      column :description, String, null: true
    end
  end
end
