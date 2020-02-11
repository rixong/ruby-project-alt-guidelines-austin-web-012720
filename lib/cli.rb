class CommandLineInterface

    def run
        greet
        check_for_user
    end

    def greet
        puts '
        Do512 - "Do awesome stuff in Austin"
        '
    end

    def check_for_user
        puts "Enter your email:"
            email = gets.chomp
        User.all.each do |user|
            if user.email_address == email
                puts "Welcome back!"
                search_by
            else
                puts create_user
            end
        end
    end

    def create_user
        puts "Enter your first name:"
            first_name = gets.chomp
        puts "Enter your last name:"
            last_name = gets.chomp
        puts "Enter your email:"
            email = gets.chomp 
        puts "Enter a password:"
            password - gets.chomp
        puts "Saved! Welcome to Do512"
        search_by
    end

    def search_by 
        puts "How would you like to search?

        1. By date (MM/DD)
        2. By category
        3. Only Freebies!"
            answer = gets.chomp
        if answer == "1"
            find_by_date # should run find_by_date, why won't it work?
        elsif answer == "2" 
            find_by_category
        else 
            only_freebies 
        end
    end

    def find_by_date
        puts "Enter a date to get started (MM/DD):"
            date = gets.chomp
        Event.all.each.with_index(1) do |event, index|
            if event.begin_time == date # depends on how Rick parses dates
            puts "#{index}. #{event.title}"
            end
         end
    end

    def find_by_category
        puts "Enter a category:"
            category = gets.chomp
        Event.all.each.with_index(1) do |event, index|
            if event.category == category
            puts "#{index}. #{event.title}"
            end
        end
    end

    def only_freebies
        Event.all.each.with_index(1) do |event, index|
            if event.is_free == true
            puts "#{index}. #{event.title}" # why won't the index start at 1 ?
            end
        end
    end

    def print_my_schedule(user)
        # how to go through the whole database and match by user?

    end


end