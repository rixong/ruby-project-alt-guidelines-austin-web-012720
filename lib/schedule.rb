class Schedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :event


  def self.make_schedule(date, new_event, cur_user)  ## new_event is from date, result of cli search of date, cur_user is User object
    event_id = Event.get_event_id_from_api_id(new_event.api_id)
    if event_id && cur_user.schedules.exists?(event_id: event_id)
      puts "You've already scheduled this event.".colorize(:red)
    else
      new_event = Event.make_event(new_event)
      Schedule.create(date: date, event_id: new_event.id, user_id: cur_user.id)
      puts "success".colorize(:green)
    end
  end

  def self.print_user_schedule(user_id)       ## sorted by date
    schedules = sort_user_schedule(user_id)
    user = User.find(user_id)
    puts "\n#{user.first_name} #{user.last_name}'s schedule:".colorize(:green)
    schedules.each_with_index do |schedule, index|
      puts "#{index + 1}. #{schedule.event.date} - #{schedule.event.title}"
    end
  end

  def self.sort_user_schedule(user_id)
    schedules = User.find(user_id).schedules
    schedules = schedules.sort { |a,b| a.event.date <=> b.event.date }
  end
  
  def self.delete_schedule(user, list_num)
    schedules = sort_user_schedule(user.id)
    schedules[list_num.to_i - 1].delete
    puts "Gone...".colorize(:magenta)
  end

end