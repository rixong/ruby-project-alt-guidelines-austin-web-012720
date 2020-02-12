class GetEvents
  
  attr_reader :title, :category, :description, :date, :time, :is_free, :api_id
  
  def initialize(title, category, description, date, time, is_free, api_id)
    @title = title
    @category = category
    @description = description
    @date = date
    @time = time
    @is_free = is_free
    @api_id = api_id
  end
  
  URL = "https://do512.com/events/"
  
  def self.get_api_by_date(date)
    response_body = import_events_from_api("2020/#{date}")        ## "mm/dd"
    events = JSON.parse(response_body)["events"]  ## returns an array of events
    events.map do |event| 
      package_events(event)
    end
  end

  def self.get_api_by_id(api_id)  
    response_body = import_events_from_api(api_id)  
    event = JSON.parse(response_body)["event"]  ## returns the single event
    package_events(event)
  end
  
  def self.list_event_titles(events)
    events.each_with_index do |event, index|
      puts "#{index + 1}. #{event.category.upcase} - #{event.title}"
    end
  end

  def self.show_more_info(event)
    puts "Title: #{event.title}"
    puts "Category: #{event.category}"
    puts "Description: #{event.description}"
  end
  
### HELPER METHODS

  def self.import_events_from_api(param)  
    url = ("#{URL}#{param}.json")
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response.body
  end
  
  def self.package_events(event)  ## parses events from api import
    # binding.pry
      new_event = GetEvents.new(
        event["title"].strip,
        event["category"].strip,
        event["excerpt"],
        self.parse_date(event["begin_time"]),
        self.parse_time(event["begin_time"]),
        event["is_free"],
        event["id"]
      )
  end
  
  def self.parse_date(info)  ## parses date & time into "mm/dd" & "HH:MM" format from "2020-02-08T19:30:00-06:00"
    split = info.split('T')
    date_arr = split[0].split('-')
    date = "#{date_arr[1]}/#{date_arr[2]}"
  end

  def self.parse_time(info)
    split = info.split('T')
    time = split[1].slice(0,5)
  end


#   def search_by 
#     puts "What would you like to see?

#      1. Events by date (MM/DD)
#      2. Show only Freebies!"
#         answer = gets.chomp
#     if answer == "1"
#         find_by_date
#     else 
#         only_freebies 
#     end
# end

#  def only_freebies
#   puts "Made it to only_freebies!"
# #         Event.all.each.with_index(1) do |event, index|
# #             if event.is_free == true
# #             puts "#{index}. #{event.title}" # why won't the index start at 1 ?
# #             end
# #         end
# end


end

## date query sample:  "https://do512.com/events/2020/02/10.json"
