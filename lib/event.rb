
class Event < ActiveRecord::Base
has_many :schedules
has_many :users, through: :schedules

def self.make_event(event)
  Event.create(title: event.title, date: event.date, category: event.category, permalink: event.permalink)
end


end

