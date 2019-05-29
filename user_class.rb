# frozen_string_literal: true

# Class of users (UserClass), the user is stored for processing in the rents.
class UserClass
  attr_accessor :id, :firstname, :lastname, :genre
  attr_reader :users

  def initialize(firstname, lastname)
    @firstname = firstname.to_s
    @lastname = lastname.to_s
    @users = []
  end

  def save
    idgenre
    return users << { id: id, firstname: firstname, lastname: lastname, genre: genre }
  end

  def idgenre
    users.empty? ? @id = 1 : @id = (users[:id]).next
    rand(2) == 1 ? @genre = 'Male' : @genre = 'Female'
  end

  def records
    @users.each do |array|
      puts "\nUser ID: #{array[:id]}\
      \nName: #{array[:firstname]} #{array[:lastname]}\
      \nGenre: #{array[:genre]}"
    end
  end
end

user = UserClass.new('Nombre1', 'Apellido1')

require_relative 'rent_class'

rent = RentClass.new(2300, user.save)

user.records

rent.give_rent(1)

puts rent.deposit(2000)

rent.payment
