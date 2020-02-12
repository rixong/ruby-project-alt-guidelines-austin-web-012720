class CommandLineInterface
    attr_accessor :cur_user

    def initialize
        @cur_user = User.first
    end

    def run
        greet
        @cur_user = User.login_or_create_user

        puts " Hi #{cur_user.first_name} #{cur_user.last_name} !"
        menu
    end

    def greet
        puts "\n\nDo512 - \"Do awesome stuff in Austin\"\n".colorize(:yellow ).colorize( :background => :light_blue)
    end

    def menu
        puts "\nWhat would you like to do?".colorize(:green)
        puts "
        1. See events by date
        2. Print my schedule
        3. List all users
        4. Settings
        5. Exit Program".colorize(:blue)
        response = gets.chomp
    case 
      when response == "1"
        choose_by_date
      when response == "2"
        puts "print_my_schedule method TBD"
      when response == "3"
        list_all_users(users)
      when response == "4"
        puts "Select an item to update:
        1. New email
        2. New password"
        answer = gets.chomp
        if answer == "1" 
            binding.pry
            cur_user.update_email
        else 
            cur_user.update_password
        end
      else
        "Invalid Entry. Enter a number."
      end
    end

      
  def greet
    puts "\nDo512 - \"Do awesome stuff in Austin\"\n".colorize(:yellow)
  end

  def choose_by_date
    # Schedule.print_user_schedule(cur_user)
    puts "Enter a date to get started (mm/dd)"
    date = gets.chomp
    result = GetEvents.get_api_by_date(date)
    puts "\nHere are the events for #{date}:\n"

    GetEvents.list_event_titles(result)
    puts "\nEnter a number to see more info on event:"
    index = gets.chomp.to_i - 1
    GetEvents.show_more_info(result[index])
    puts "\nEnter a number to schedule an event:"
    index = gets.chomp.to_i - 1
    new_event = Event.make_event(result[index])
    Schedule.create(date: date, event_id: new_event.id, user_id: User.cur_user.id)

    results = GetEvents.list_event_titles(result)
    
  end
  


end