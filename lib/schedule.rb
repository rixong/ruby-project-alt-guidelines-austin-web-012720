class Schedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :event


  def self.print_user_schedules       ## sorted by date
    schedules = User.cur_user.schedules
    schedules = schedules.sort { |a,b| a.event.date <=> b.event.date }
    schedules.each do |schedule|
      puts "#{schedule.event.date} - #{schedule.event.title}"
    end
  end


end