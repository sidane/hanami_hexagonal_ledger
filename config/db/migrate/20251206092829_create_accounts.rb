# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :accounts do
      primary_key :id
      column :name, String, null: false
      column :balance_cents, Integer, null: false, default: 0
      column :currency, String, null: false, default: "GBP"
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
