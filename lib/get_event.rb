require 'net/http'
require 'open-uri'
require 'json'

class GetEvent < ActiveRecord::Base
  URL = "https://do512.com/events/"

  def self.import_events_by_date(date)  ##  "mm/dd"

    # url = "https://do512.com/events/2020/02/10.json"
    
    url = ("#{URL}2020/#{date}.json")
    
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response_body = response.body
    events = JSON.parse(response_body)["events"] ## returns an array of events
    # puts events[0]["title"]

    self.add_events(events)

  end

  def self.add_events(events)
    events.map do |event|
      row = GetEvent.new
      row.title = event["title"]
      row.category = event["category"]
      #row.date = event["title"]
      row.event_id_num = event["id"]
      row.save
    end
  end
end