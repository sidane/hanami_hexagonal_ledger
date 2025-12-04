# frozen_string_literal: true

module HanamiHexagonalLedger
  class Routes < Hanami::Routes
    # Add your routes here. See https://guides.hanamirb.org/routing/overview/ for details.

    slice :ledger, at: "/ledger" do
    end
  end
end
