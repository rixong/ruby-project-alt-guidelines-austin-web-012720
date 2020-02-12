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
        1. List Events by Date
        2. Schedules
        3. List All Users
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
                1. Update Email Address
                2. Update Password
                3. Delete User
                M - Main Menu"
                answer = gets.chomp
                  case answer 
                        when answer == "1" 
                            update_email
                        when answer == "2"
                            update_password
                        when answer == "3"
                            puts "Are you sure you want to delete this user? (Y/N)"
                              delete_user = gets.chomp
                              if delete_user == "Y"
                                User.delete_user
                                puts "Deleted current user"
                              else
                                  menu
                              end
                        else
                        "Invalid Entry: Enter a number."
                    end
              when response == "5"
                begin
                  exit
                rescue SystemExit
                  puts "Exiting Program"
              end
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
    puts "Choose 1 to see more info or 2 schedule an event"
    puts "\nEnter a number to schedule an event:"
    index = gets.chomp.to_i - 1
    new_event = Event.make_event(result[index])
    Schedule.create(date: date, event_id: new_event.id, user_id: User.cur_user.id)

    results = GetEvents.list_event_titles(result)
    
  end

end