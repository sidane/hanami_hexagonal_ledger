module BudgetLedger
  module Domain
    module ValueObjects
      class Money
        attr_reader :amount, :currency

        def initialize(amount, currency: "GBP")
          @amount = normalize_amount(amount)
          @currency = currency
        end

        def to_s
          "#{amount.to_s("F")} #{currency}"
        end

        def +(other)
          assert_same_currency!(other)
          Money.new(amount + other.amount, currency: currency)
        end

        def -(other)
          assert_same_currency!(other)
          Money.new(amount - other.amount, currency: currency)
        end

        def negative?
          amount.negative?
        end

        def zero?
          amount.zero?
        end

        def ==(other)
          amount == other.amount && currency == other.currency
        end

        protected

        def normalize_amount(raw_amount)
          case raw_amount
          when BigDecimal
            raw_amount
          when String
            BigDecimal(raw_amount)
          when Integer, Float
            BigDecimal(raw_amount.to_s)
          else
            raise "Unsupported amount type #{raw_amount.class}"
          end
        end

        def assert_same_currency!(other)
          raise "Currency mismatch" unless currency == other.currency
        end
      end
    end
  end
end
