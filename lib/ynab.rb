require "ynab/version"
require_relative './budget_parser'
require_relative './errors'

module Ynab
  def self.open file_path
    self::Budget.open file_path
  end

  class Budget
    attr_reader :transactions,
                :payees,
                :categories,
                :accounts
    def initialize
      @transactions = []
      @payees = []
      @categories = []
      @accounts = []
    end

    def add_transaction transaction
      @transactions = @transactions + Array(transaction)
    end

    def add_payee payee
      @payees = @payees + Array(payee)
    end

    def add_category category
      @categories = @categories + Array(category)
    end

    def add_account account
      @accounts = @accounts + Array(account)
    end

    def self.open file_path
      BudgetParser.new(file_path).open
      self.new
    end
  end

  class Transaction
    attr_reader :account,
                :date,
                :payee,
                :category,
                :memo,
                :amount

    def initialize account,
                   date,
                   payee,
                   category,
                   memo,
                   amount

      @account = account
      @date = date 
      @payee = payee 
      @category = category 
      @memo = memo 
      @amount = amount
    end

    def inflow
      @amount if @amount > 0
    end

    def outflow
      @amount if @amount < 0
    end
  end
end
