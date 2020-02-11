require 'net/http'
require 'open-uri'
require 'json'

class Event < ActiveRecord::Base
  has_many :schedules
  has_many :users, through: :schedules

  URL = "https://do512.com/events/"

  def self.import_events_by_date(date)  # "MM/DD"
    # url format = "https://do512.com/events/2020/02/10.json"
    url = ("#{URL}2020/#{date}.json")
    
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response_body = response.body
    events = JSON.parse(response_body)["events"] 
    # returns an array of events
    self.add_events(events)
  end

  def self.add_events(events)
    events.map do |event|
      row = Event.new
      row.title = event["title"].strip
      row.category = event["category"].strip
      row.date = event["begin_time"]
      row.event_id_num = event["id"]
      row.is_free = event["is_free"]
      row.description = event["excerpt"]
      row.save
    end
  end

  def self.list_event_titles(date)
    puts "Here are all events:"
    Event.all.each.with_index(1) do |event, index|
      puts "#{index}. #{event.title}"
    end
  end
end