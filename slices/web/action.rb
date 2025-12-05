# auto_register: false
# frozen_string_literal: true

module Web
  class Action < HanamiHexagonalLedger::Action
    def json_response(response:, status:)
      response.status = status
      response.format = :json
      response.body = yield.to_json if block_given?
    end
  end
end
