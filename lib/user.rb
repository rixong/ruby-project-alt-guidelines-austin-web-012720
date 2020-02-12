require "tty-prompt"

class User < ActiveRecord::Base

  has_many :schedules, :dependent => :delete_all
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
    prompt = TTY::Prompt.new
    password = prompt.mask("Enter password:")
      if user.password == password
          puts "correct password"
          return user
      else
      puts "Error: Invalid Password"
          User.enter_password(user)
      end
  end

  def self.create_user
    puts "Enter your first name:"
        first_name = gets.chomp     
    puts "Enter your last name:"
        last_name = gets.chomp
    puts "Enter your email:"
        email = gets.chomp
        prompt = TTY::Prompt.new 
    password = prompt.mask("Enter a password:")  
    user = User.create(first_name: first_name, last_name: last_name, email_address: email, password: password)
    puts "Saved! Welcome to Do512"
    return user
  end

  def self.update_email(cur_user)
    puts "Enter your new email address:"
    email = gets.chomp
    cur_user.update(email_address: email)
    puts "Email address updated!"
    
   end

   def self.update_password(cur_user)
    prompt = TTY::Prompt.new
    password = prompt.mask("Enter a new password:")
    cur_user.password = password
    puts "Your new password is #{password.length} characters long."
   end

   def self.delete_user(cur_user)
    User.delete(cur_user)
    puts "Deleted current user"
   end

   def self.list_users
    puts "\nAll Registered Users\n"
    User.all.each.with_index(1) do |user, index|
      puts "#{index}. #{user.first_name} #{user.last_name}"
    end
   end

end