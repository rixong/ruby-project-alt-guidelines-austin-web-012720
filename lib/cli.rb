class CommandLineInterface
  attr_accessor :cur_user
  def initialize
      @cur_user = nil
  end
  
  def run
      greet
      @cur_user = User.login_or_create_user
      main_menu
  end
  
  def greet
    puts "\n"
    puts "
    ooo.          oooooo .o .oPYo. 
    8  `8.        8       8     `8 
    8   `8 .oPYo. 8pPYo.  8    oP' 
    8    8 8    8     `8  8 .oP'   
    8   .P 8    8     .P  8 8'     
    8ooo'  `YooP' `YooP'  8 8ooooo".colorize(:cyan) 
    puts "
    .....:::.....::.....::.........
    :::::::::::::::::::::::::::::::
    :::::::::::::::::::::::::::::::".colorize(:green)
    puts '
      "Do awesome stuff in Austin" '.colorize(:blue)
  end
  
  def main_menu
    puts "\nMain Menu: ".colorize(:cyan)
    puts "\t1. List Events by Date".colorize(:blue)
    puts "\t2. Schedules".colorize(:blue)
    puts "\t3. List All Users".colorize(:blue)
    puts "\t4. Settings".colorize(:blue)
    puts "\t5. Exit Program".colorize(:blue)
    response = gets.chomp
      case response
        when "1"
          choose_by_date_menu
        when "2"
          schedule_menu
        when "3"
          list_all_users_menu
        when "4"
          settings_menu
        when "5"
          exit_prompt
        else
          main_menu
      end
  end

  def choose_by_date_menu
    result = nil
    puts "Enter a date (mm/dd): ".colorize(:cyan)
    date = gets.chomp
    
    if !GetEvents.date_validation(date)  ## Validation  add to CLI
      puts "Incorrect format!".colorize(:red)
      choose_by_date_menu
    end
    
    result = GetEvents.get_api_by_date(date)
    GetEvents.list_event_titles(result, date)

    puts "\nChoose a number to see more info:".colorize(:cyan)
    index = gets.chomp.to_i - 1
    GetEvents.show_more_info(result[index])
    puts "Event Menu:".colorize(:cyan)
    puts "\t1. Schedule this event".colorize(:blue)
    puts "\t2. View more events".colorize(:blue)
    puts "\tM - Main Menu".colorize(:blue)
    answer = gets.chomp
    case answer
      when "1"
        Schedule.make_schedule(date, result[index], cur_user)
        main_menu
      when "2"
        choose_by_date_menu
      else
        main_menu
    end
  end
  
  def schedule_menu
    puts "\nSchedule Menu:".colorize(:cyan)
    puts "\t1. View my Schedule".colorize(:blue)
    puts "\t2. View a Friend's Schedule".colorize(:blue)
    puts "\t3. Schedule an event".colorize(:blue)
    puts "\tM. Main Menu".colorize(:blue)
    response = gets.chomp

    case response
      when "1"
        view_schedule
      when "2"
        User.list_users
        puts "\nChoose friend:".colorize(:blue)
        response = gets.chomp
        Schedule.print_user_schedule(response)
        main_menu
      when "3"
        choose_by_date_menu
        else 
          main_menu
    end
  end

  def view_schedule
    Schedule.print_user_schedule(cur_user.id)
    puts "\n1. Go back:".colorize(:blue)
    puts "2. Delete event ".colorize(:blue)
    response = gets.chomp
    case response
      when '1'
        main_menu
      when '2'
        puts "Enter the number of the event to delete:".colorize(:cyan)
        choice = gets.chomp
        puts "Are you sure? (y)".colorize(:magenta)
        response = gets.chomp
        if response == "y"
          Schedule.delete_schedule(cur_user, choice)
          puts "Event deleted".colorize(:green)
        else
          puts "Event not deleted".colorize(:red)
        end
        main_menu
      else 
        main_menu
    end
  end

  def list_all_users_menu
    User.list_users
    main_menu
  end

  def settings_menu
    puts "\nSettings Menu:".colorize(:cyan)
    puts "\t1. Update Email Address".colorize(:blue)
    puts "\t2. Update Password".colorize(:blue)
    puts "\t3. Delete User".colorize(:blue)
    puts "\tM. Main Menu".colorize(:blue)
    answer = gets.chomp
    case answer
      when "1" 
          User.update_email(cur_user)
          settings_menu
      when "2"
          User.update_password(cur_user)
          settings_menu
      when "3"
        puts "Are you sure you want to delete this user??? (Y/N)".colorize(:red)
        choice = gets.chomp
        if choice.downcase == "y"
          User.delete_user(cur_user)
          run
        else
          puts "User not deleted.".colorize(:yellow)
          settings_menu
        end
      else
        main_menu
    end
  end

  def exit_prompt
    begin
      exit!
    rescue SystemExit
      puts "Goodbye...".colorize(:purple)
    end
  end

end