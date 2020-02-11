class GetEvents

  attr_reader :title, :category, :description, :date, :time, :is_free, :permalink
#comment for git
  def initialize(title, category, description, date, time, is_free, permalink)
    @title = title
    @category = category
    @description = description
    @date = date
    @time = time
    @is_free = is_free
    @permalink = permalink
  end

  URL = "https://do512.com/events/"

  def self.import_events_api_by_date(date)  ##  "mm/dd"
    url = ("#{URL}2020/#{date}.json")
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response_body = response.body
    events = JSON.parse(response_body)["events"] ## returns an array of events
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
  
  def self.get_events(date)
    events = self.import_events_api_by_date(date)
    events.map do |event|
      new_event = GetEvents.new(
        event["title"].strip,
        event["category"].strip,
        event["excerpt"],
        self.parse_date(event["begin_time"]),
        self.parse_time(event["begin_time"]),
        event["is_free"],
        event["permalink"]
      )
    end
  end

  def self.list_event_titles(events)
    events.each_with_index do |event, index|
      puts "#{index + 1}. #{event.title}"
    end
  end

  def self.show_more_info(event)
    puts "Title: #{event.title}"
    puts "Category: #{event.category}"
    puts "Description: #{event.description}"
    
  end

  def self.find_by_permalink(link)  ## 2020/2/8/bone-rattle-stand-up-showcase-1580320720
    url = ("#{URL}#{link}.json")
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response_body = response.body
    event = JSON.parse(response_body)["event"] ## returns an array of events
    binding.pry
    puts event['title']
  end

  def search_by 
    puts "What would you like to see?

     1. Events by date (MM/DD)
     2. Show only Freebies!"
        answer = gets.chomp
    if answer == "1"
        find_by_date
    else 
        only_freebies 
    end
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

 def only_freebies
  puts "Made it to only_freebies!"
#         Event.all.each.with_index(1) do |event, index|
#             if event.is_free == true
#             puts "#{index}. #{event.title}" # why won't the index start at 1 ?
#             end
#         end
end


end

## date query sample:  "https://do512.com/events/2020/02/10.json"
## permalink query sample: "https://do512.com/events/2020/2/8/bone-rattle-stand-up-showcase-1580320720"