class CommandLineInterface
    def run
        User.greet
        User.login_or_create_user
    end
end

<<<<<<< HEAD
# TEST TO UPLOAD TO GITHUB - JESSICA
=======
    def login_or_create_user
        puts 'Make a selection:
        1. Returning User - Login
        2. New User - Create Profile
        '
        selection = gets.chomp
        if selection == "1" 
            enter_email
        else
            create_user
        end
    end

    def enter_email 
        puts "Enter your email:"
            email = gets.chomp
            if User.find_by(email_address: email)
                enter_password
            else
                puts "Invalid Email"
                login_or_create_user
            end
        end
    end
    
    def enter_password
        puts "Enter your password:"
            password = gets.chomp
            if User.find_by(password: password)
                puts "Welcome back!"
                search_by
            else
            puts "Error: Invalid Password"
                enter_password
            end
    end

#     def check_for_user
#         puts "Enter your email:"
#             email = gets.chomp
#         User.all.each do |user|
#             if user.email_address == email
#                 puts "Welcome back!"
#                 search_by
#             else
#                 puts create_user
#             end
#         end
#     end

#     def create_user # Move to User class
#         puts "Enter your first name:"
#             first_name = gets.chomp
#         puts "Enter your last name:"
#             last_name = gets.chomp
#         puts "Enter your email:"
#             email = gets.chomp 
#         puts "Enter a password:"
#             password - gets.chomp
#         puts "Saved! Welcome to Do512"
#         search_by
#     end

    def search_by 
        puts "Made it to search_by method"
#         puts "How would you like to search?

#         1. By date (MM/DD)
#         2. By category
#         3. Only Freebies!"
#             answer = gets.chomp
#         if answer == "1"
#             find_by_date # should run find_by_date, why won't it work?
#         elsif answer == "2" 
#             find_by_category
#         else 
#             only_freebies 
#         end
    end

#     def find_by_date
#         puts "Enter a date to get started (MM/DD):"
#             date = gets.chomp
#         Event.all.each.with_index(1) do |event, index|
#             if event.begin_time == date # depends on how Rick parses dates
#             puts "#{index}. #{event.title}"
#             end
#          end
#     end

#     def find_by_category
#         puts "Enter a category:"
#             category = gets.chomp
#         Event.all.each.with_index(1) do |event, index|
#             if event.category == category
#             puts "#{index}. #{event.title}"
#             end
#         end
#     end

#     def only_freebies
#         Event.all.each.with_index(1) do |event, index|
#             if event.is_free == true
#             puts "#{index}. #{event.title}" # why won't the index start at 1 ?
#             end
#         end
#     end

#     def print_my_schedule(user)
#         # how to go through the whole database and match by user?

#     end
# #  def run
# #   #login
# #   greet
# #   choose_by_date
# #  end



# #  def greet
# #   puts "hello, Unknown user!"
# # end


def choose_by_date
  # Event.destroy_all
  puts "Enter a date to get started (mm/dd)"
  date = gets.chomp
  result = GetEvents.get_events(date)
  puts "\nHere are the events for #{date}:\n"
  GetEvents.list_event_titles(result)
  puts "\nEnter a number to see more info on event:"
  index = gets.chomp.to_i - 1
  GetEvents.show_more_info(result[index])
  puts "\nEnter a number to schedule an event:"
  index = gets.chomp.to_i - 1
  new_event = Event.make_event(result[index])
  Schedule.create(date: date, event_id: new_event.id, user_id: User.cur_user.id)


#  end


# end
>>>>>>> 1fd9b0d249eb9eeae170aa9c81a3a5a19ba74849
