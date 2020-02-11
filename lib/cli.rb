class CommandLineInterface

 def run
  #login
  greet
  choose_by_date
 end



 def greet
  puts "hello, Unknown user!"
end

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
  # binding.pry
  Schedule.create(date: date, event_id: new_event.id, user_id: User.cur_user.id)

 end


end