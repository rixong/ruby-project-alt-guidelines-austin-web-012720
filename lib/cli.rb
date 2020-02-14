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
  prompt = TTY::Prompt.new(active_color: :cyan)
    response = prompt.select("\nMain Menu") do |menu|
      menu.choice " - List Events by Date"
      menu.choice " - Schedules"
      menu.choice " - List All Users"
      menu.choice " - Settings"
      menu.choice " - Exit Program"
    end
    case response
      when " - List Events by Date"
        choose_by_date_menu
      when " - Schedules"
        schedule_menu
      when " - List All Users"
        list_all_users_menu
      when " - Settings"
        settings_menu
      when " - Exit Program"
        exit_prompt
      else
        main_menu
    end
  end


  def choose_by_date_menu
    result = nil
    puts "\nEnter a date (mm/dd): ".colorize(:cyan)
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

    prompt = TTY::Prompt.new(active_color: :cyan)
    response = prompt.select("\nEvent Menu") do |menu|
      menu.choice " - Schedule this event"
      menu.choice " - View more events"
      menu.choice " - Main Menu"
    end

      case response
        when " - Schedule this event"
          Schedule.make_schedule(date, result[index], cur_user)
          main_menu
        when " - View more events"
          choose_by_date_menu
        else
          main_menu
      end
  end

  def schedule_menu
    prompt = TTY::Prompt.new(active_color: :cyan)
    answer = prompt.select("\nSchedule Menu:") do |menu|
    menu.choice " - View my Schedule"
    menu.choice " - View a Friend's Schedule"
    menu.choice " - Schedule an event"
    menu.choice " - Main Menu"
    end

    case answer
      when " - View my Schedule"
        view_schedule
      when " - View a Friend's Schedule"
        User.list_users
        puts "\nChoose friend:".colorize(:blue)
        response = gets.chomp
        Schedule.print_user_schedule(response)
        main_menu
      when " - Schedule an event"
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
    prompt = TTY::Prompt.new(active_color: :cyan)
    response = prompt.select("\nSettings Menu") do |menu|
      menu.choice " - Update Email Address"
      menu.choice " - Update Password"
      menu.choice " - Delete User"
      menu.choice " - Main Menu"
      end
   
    case response
      when " - Update Email Address"
          User.update_email(cur_user)
          settings_menu
      when " - Update Password"
          User.update_password(cur_user)
          settings_menu
      when " - Delete User"
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