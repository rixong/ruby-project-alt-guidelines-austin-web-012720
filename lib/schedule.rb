class Schedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  

  def self.make_schedule(date, new_event, cur_user)  ## new_event is from date, result of cli search of date, cur_user is User object
    event_id = Event.get_event_id_from_api_id(new_event.api_id)
    if event_id && Schedule.find_by(event_id: event_id)
      puts "You've already scheduled this event."
    else
      new_event = Event.make_event(new_event)
      Schedule.create(date: date, event_id: new_event.id, user_id: cur_user.id)
      puts "success"
    end
  end

  def self.print_user_schedule(user)
      ## sorted by date
    schedules = user.schedules
    schedules = schedules.sort { |a,b| a.event.date <=> b.event.date }
    schedules.each do |schedule|
      puts "#{schedule.event.date} - #{schedule.event.title}"
    end
  end

end