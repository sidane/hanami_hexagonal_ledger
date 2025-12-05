# frozen_string_literal: true

module HanamiHexagonalLedger
  class Routes < Hanami::Routes
    # Add your routes here. See https://guides.hanamirb.org/routing/overview/ for details.

    slice :ledger, at: "/ledger" do
      get "/ping", to: "ping.index"
    end

    slice :web, at: "/" do
      post "/accounts", to: "accounts.create"
      post "/accounts", to: "accounts.create"
    end
  end
end
