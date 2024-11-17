# frozen_string_literal: true

require 'csv'

ACTIONS = {
  deposit: 'deposit',
  withdraw: 'withdraw',
  transfer: 'transfer'
}.freeze

Accounts = Set[]

Account = Struct.new(:name, :balance, :transactions) do
  # @param [String] name
  # @param [Integer] balance
  # @param [Array<Transaction>] transactions
  def initialize(name:, balance: 0, transactions: [])
    self.name = name
    self.balance = balance
    self.transactions = transactions
  end

  # @param [Integer]  amount
  def deposit(amount)
    self.balance += Integer(amount)
  end

  def reconcile
    transactions.each do |transaction|
      amount = transaction.amount

      case transaction.action
      when ACTIONS[:deposit]
        deposit(amount)
      when ACTIONS[:withdraw]
        withdraw(amount)
      when ACTIONS[:transfer]
        destination = get_destination_account(transaction.destination)

        transfer(amount, destination)
      else
        puts 'Unknown action.'
      end
    end
  end

  # @param [Integer] amount
  # @param [Account] destination
  def transfer(amount, destination)
    withdraw(amount)

    destination.deposit(amount)
  end

  # @param [Integer] amount
  def withdraw(amount)
    self.balance -= Integer(amount)
  end
end

Transaction = Struct.new(:timestamp, :origin, :action, :amount, :destination) do
  # @param [?] timestamp
  # @param [String] origin
  # @param [String] action
  # @param [Integer] amount
  # @param [String] destination
end

def create_account(name)
  Account.new(name: name)
end

def create_accounts(data)
  grouped_accounts = data.group_by { |item| item[1] }
  grouped_accounts.each do |name, transactions|
    account = create_account(name)
    account.transactions = create_transactions(transactions)

    Accounts << account
  end
end

def create_transactions(data)
  data.map { |transaction| Transaction.new(*transaction) }
end

def get_destination_account(name)
  Accounts.select { |account| account.name == name }.first
end

def reconcile_accounts
  Accounts.map(&:reconcile)
end

# read csv
data_csv = File.read('data/data.csv')
data = CSV.parse(data_csv)

create_accounts(data)
reconcile_accounts

# Alice.balance = 10
# Bob.balance   = 35
pp Accounts
