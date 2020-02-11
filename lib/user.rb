class User < ActiveRecord::Base
  has_many :schedules
  has_many :events, through: :schedules

  def self.cur_user 
    User.find(2)
  end

  def self.greet
    puts '
    Do512 - "Do awesome stuff in Austin"
    '
  end

  def self.login_or_create_user
    puts 'Make a selection:
    1. Returning User - Login
    2. New User - Create Profile
    '
    selection = gets.chomp
    if selection == "1" 
        User.enter_email
    else
        User.create_user
    end
  end

    def self.enter_email 
      puts "Enter your email:"
          email = gets.chomp
          if User.find_by(email_address: email)
              User.enter_password
          else
              puts "Invalid Email"
              User.login_or_create_user
          end
      end

  def self.enter_password
    puts "Enter your password:"
        password = gets.chomp
        if User.find_by(password: password)
            puts "Welcome back!"
            User.search_by
        else
        puts "Error: Invalid Password"
            User.enter_password
        end
  end

def self.create_user # Move to User class, first_name, last_name, email_address_password
  puts "Enter your first name:"
      first_name = gets.chomp     
  puts "Enter your last name:"
      last_name = gets.chomp
  puts "Enter your email:"
      email = gets.chomp 
  puts "Enter a password:"
      password = gets.chomp
User.create(first_name: first_name, last_name: last_name, email_address: email, password: password)
  puts "Saved! Welcome to Do512"
  GetEvents.search_by
end


end