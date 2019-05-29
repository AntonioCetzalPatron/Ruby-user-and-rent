# frozen_string_literal: true

# Class of the payment, an payment is
# given to some user and he is allowed to pay to his account
class RentClass
  attr_accessor :id, :amount, :users
  attr_reader :rent, :pay

  def initialize(amount, user)
    puts "Amount: $#{amount}"
    @amount = amount
    @users = user
    @rent = []
    @pay = []
  end

  def give_rent(user_id)
    return "Invalid amount (Amount: $#{@amount})." if @amount < 1

    firstname(user_id)
    next_id
    @rent << { id: @id, initial_amount: @amount, users: @users, amount: @amount }
  end

  def deposit(amount)
    return "Invalid amount (Amount: $#{amount})." if amount < 1

    return "Amount can not be greater thah $#{@amount}" if amount > @amount

    puts findrent
    result = @amount - amount
    @rent[@id][:amount] = result
    @pay.push user: @users, count: result, payment: amount
    return "\nPayment: $#{amount}\
    \nAmount to pay now: $#{result}"
  end

  def next_id
    rent.empty? ? @id = 1 : @id = (rent[-1][:id]).next
  end

  def firstname(id)
    (0..(@users[-1][:id]) - 1).each do |i|
      next unless @users[i][:id] == id

      return @users = { id: @users[i][:id], lastname: @users[i][:lastname] }
    end
    raise "The user is not in the records (User ID: #{id})"
  end

  def findrent
    (0..(@rent.length - 1)).each do |i|
      next unless @rent[i][:id] == @id

      @id = i

      return "\nRent ID: #{@rent[i][:id]}\
      \nUser: #{@rent[i][:users][:lastname]}\
      \nAmount for pay: $#{@rent[i][:amount]}\n"
    end
    raise "The rent is not in the records (Rent ID: #{@id}, Records: #{@rent})"
  end

  def payment
    (0..(@pay.length - 1)).each do |i|
      next unless @pay[i][:users] == @users

      return "\nUser: #{@rent[i][:users][:lastname]}\
      \nPay: $#{@pay[i][:payment]}\
      \nCount: $#{@pay[i][:count]}\n"
    end
  end
end
