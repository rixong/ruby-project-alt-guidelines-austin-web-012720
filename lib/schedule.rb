class Schedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  

  def self.make_schedule(date, new_event, cur_user)
    if !Schedule.find_by(event_id: new_event)
      puts "here"
    Schedule.create(date: date, event_id: new_event, user_id: cur_user)
    else
      puts "You've already scheduled this event."
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