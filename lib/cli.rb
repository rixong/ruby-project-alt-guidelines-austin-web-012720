class CommandLineInterface
<<<<<<< HEAD
    attr_accessor :cur_user

    def initialize
        @cur_user = User.first
    end

    def run
        greet
        # @cur_user = User.login_or_create_user

        puts " Hi #{cur_user.first_name} #{cur_user.last_name} !"
        main_menu
    end

    def greet
        puts "\n\nDo512 - \"Do awesome stuff in Austin\"\n".colorize(:yellow ).colorize( :background => :light_blue)
    end

    def main_menu
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
              puts "choose_by_date"
              choose_by_date_menu
            when response == "2"
              puts "print_my_schedule method TBD"
              print_user_schedule_menu
            when response == "3"
              list_all_users_menu
            when response == "4"
              puts "Setiings"
              settings_menu
            when response == "5"
              begin
                exit
              rescue SystemExit
                puts "Exiting Program"
            end
          end
    end
            

  def settings_menu
    puts "Make a selection:
    1. Update Email Address
    2. Update Password
    3. Delete User
    M - Main Menu"
    answer = gets.chomp
      case  
        when answer == "1" 
          puts "choice 1"
            # User.update_email(cur_user)
        when answer == "2"
          puts "choice 2"
            # update_password
        when answer == "3"
          puts "choice 3"
          puts "Are you sure you want to delete this user? (Y/N)"
          delete_user = gets.chomp
          if delete_user == "Y"
            # User.delete_user
            puts "Deleted current user"
          else
              menu
          end
        else
        "Invalid Entry: Enter a number."
      end
  end


  def choose_by_date_menu
    puts "Choose by date"
    puts "Enter to see more info"
    main_menu
    # # Schedule.print_user_schedule(cur_user)
    # puts "Enter a date to get started (mm/dd)"
    # date = gets.chomp
    # result = GetEvents.get_api_by_date(date)
    # puts "\nHere are the events for #{date}:\n"

    # GetEvents.list_event_titles(result)
    # puts "\nEnter a number to see more info on event:"
    # index = gets.chomp.to_i - 1
    # GetEvents.show_more_info(result[index])
    # puts "Choose 1 to see more info or 2 schedule an event."
  
    # index = gets.chomp.to_i - 1
    # new_event = Event.make_event(result[index])
    # Schedule.create(date: date, event_id: new_event.id, user_id: User.cur_user.id)

    # results = GetEvents.list_event_titles(result)
    
=======
  attr_accessor :cur_user
  def initialize
      @cur_user = nil
  end
  
  def run
      greet
      @cur_user = User.login_or_create_user
      puts " Hi #{cur_user.first_name} #{cur_user.last_name} !"
      main_menu
  end
  
  def greet
      puts "\n\nDo512 - \"Do awesome stuff in Austin\"\n".colorize(:yellow ).colorize( :background => :light_blue)
  end
  
  def main_menu
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
            choose_by_date_menu
          when response == "2"
            schedule_menu
          when response == "3"
            list_all_users_menu
          when response == "4"
            settings_menu
          when response == "5"
           exit_prompt
          else
            main_menu
        end
  end

  
  def choose_by_date_menu
    result = nil
    puts "Enter a date to get started (mm/dd)"
    date = gets.chomp
    
    if !GetEvents.date_validation(date)  ## Validation  add to CLI
      puts "Incorrect format."
      choose_by_date_menu
    end
    
    result = GetEvents.get_api_by_date(date)
    puts "\nHere are the events: #{date}:"
    GetEvents.list_event_titles(result)
    puts "\nChoose a number to see more info:"
    index = gets.chomp.to_i - 1
    GetEvents.show_more_info(result[index])
    puts "Make a selection:
    1. Schedule this event
    2. View more events
    M - Main Menu"
    answer = gets.chomp
    case 
    when answer == "1"
      Schedule.make_schedule(date, result[index], cur_user)
      main_menu
    when answer == "2"
      choose_by_date_menu
    else
      main_menu
    end
  end
  
  def schedule_menu
    puts "Make a selection:
            1. Print My Schedule
            2. Print a Friend's Schedule
            M - Main Menu"
            response = gets.chomp
              if response == "1"
              Schedule.print_user_schedule(cur_user)
              main_menu
              elsif response == "2"
                list_all_users_menu
              else
                choose_by_date_menu
              end
    puts "print user schedule menu"
    main_menu
  end

  
  def list_all_users_menu
    User.list_users
    main_menu
>>>>>>> 0676c41685786a6b72b2291f2941cc78a30e76a0
  end

  def print_user_schedule_menu
    puts "print user schedule menu"
    main_menu
  end

  def list_all_users_menu
    puts "list_all_users_menu"
    main_menu
  end

  def settings_menu
    puts "Make a selection:
    1. Update Email Address
    2. Update Password
    3. Delete User
    M - Main Menu"
    answer = gets.chomp
    case  
      when answer == "1" 
        puts "choice 1"
          User.update_email(cur_user)
      when answer == "2"
        puts "choice 2"
          User.update_password(cur_user)
      when answer == "3"
        puts "choice 3"
        puts "Are you sure you want to delete this user? (Y/N)"
        choice = gets.chomp
        if choice.downcase == "y"
          User.delete_user(cur_user)
          run
        else
          puts "User not deleted."
           settings_menu
        end
      else
        puts "Invalid Entry: Enter a number."
    end
    main_menu
  end

  def exit_prompt
    begin
      exit!
    rescue SystemExit
      puts "Exiting Program"
    end
  end


end