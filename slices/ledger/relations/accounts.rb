module Ledger
  module Relations
    class Accounts < Hanami::DB::Relation
      schema(:accounts, infer: true)
    end
  end
end
