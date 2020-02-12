class User < ActiveRecord::Base
  has_many :schedules
  has_many :events, through: :schedules

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
        if user = User.find_by(email_address: email)
            User.enter_password(user)
        else
            puts "Invalid Email"
            User.login_or_create_user
        end
    end

  def self.enter_password(user)
    puts "Enter your password:"
    password = gets.chomp
      if user.password == password
          puts "Welcome back!"
          return user
      else
      puts "Error: Invalid Password"
          User.enter_password
      end
  end

  def self.create_user
    puts "Enter your first name:"
        first_name = gets.chomp     
    puts "Enter your last name:"
        last_name = gets.chomp
    puts "Enter your email:"
        email = gets.chomp 
    puts "Enter a password:"
        password = gets.chomp
    user = User.create(first_name: first_name, last_name: last_name, email_address: email, password: password)
    puts "Saved! Welcome to Do512"
    return user
  end

end