class CommandLineInterface
    attr_accessor :cur_user
    def initialize
        @cur_user = User.first
    end

    def run
        greet
        # @cur_user = User.login_or_create_user
  
        puts " Hi #{cur_user.first_name} #{cur_user.last_name} !"
        choose_by_date
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
    results = GetEvents.list_event_titles(result)
    # puts "\nEnter a number to see more info on event:"
    # index = gets.chomp.to_i - 1
    # GetEvents.show_more_info(result[index])
    # puts "\nEnter a number to schedule an event:"
    # index = gets.chomp.to_i - 1
    # new_event = Event.make_event(result[index])
    # Schedule.make_schedule(date, new_event.id, cur_user.id)

   end


end

