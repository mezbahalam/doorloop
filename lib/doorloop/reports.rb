# frozen_string_literal: true

module DoorLoop
  class Reports
    def initialize(client)
      @client = client
      @logger = client.logger
    end

    def rent_roll(options = {})
      @client.get('reports/rent-roll', options)
    end

    def profit_loss_summary(options = {})
      unless options[:filter_accountingMethod]
        @logger.error("filter_accountingMethod is required (CASH / ACCRUAL)")
        return nil
      end

      @client.get('reports/profit-and-loss-summary', options)
    end

    def cash_flow_statement(options = {})
      unless options[:filter_accountingMethod]
        @logger.error("filter_accountingMethod is required (CASH / ACCRUAL)")
        return nil
      end

      @client.get('reports/cash-flow-statement', options)
    end

    def balance_sheet_summary(options = {})
      unless options[:filter_accountingMethod]
        @logger.error("filter_accountingMethod is required (CASH / ACCRUAL)")
        return nil
      end

      @client.get('reports/balance-sheet-summary', options)
    end
  end
end
