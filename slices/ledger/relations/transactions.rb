# frozen_string_literal: true

module Ledger
  module Relations
    class Transactions < Hanami::DB::Relation
      schema(:transactions, infer: true)
    end
  end
end
