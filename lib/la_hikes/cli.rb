class LaHikes::CLI

    def call
        puts ""
        puts ""
        puts "***** Welcome to LA Hikes! *****"
        puts ""
        puts "------- Quote of the day: -------"
        puts "#{LaHikes::Quote.random_quote}"
        LaHikes::Scraper.new.make_hikes
        menu
    end

    def menu

        puts ""
        puts "List hikes by name, enter '1'"
        puts "List hikes by location, enter '2'"
        puts "List hikes by difficulty, enter '3'"
        puts "Be brave and do a random hike, enter '4"
        puts "To exit the program, enter 'exit'"
        puts ""
        puts "Please make a selection:"
            
        
        input = gets.strip
       
        if input == '1'
            puts ""
            list_hikes
            puts ""
            puts "Select a hike from menu:"
            num = gets.to_i
            hike_selector(num) 
            return_to_menu?
         elsif input == '2'
            puts ""
            list_location
            puts ""
            puts "Select a location from the menu:"
            num = gets.to_i
            location_selector(num)
            puts "Hikes are listed by index number."
            puts "Please select index number from list shown for more information."
            puts "Or to return to the main menu, enter '311'"
            num = gets.to_i
            hike_selector(num) 
            return_to_menu?
         elsif input == '3'
            puts ""
            list_difficulty
            puts ""
            puts "Select difficulty level from the menu:"
            num = gets.to_i
            difficulty_selector(num)
            puts "Hikes are listed by index number."
            puts "Please select index number from list shown for more information."
            puts "Or to return to the main menu, enter '311'"
            num = gets.to_i
            hike_selector(num) 
            return_to_menu?
         elsif input == '4' 
            puts ""
            puts "Hike of the day:" 
            random_hike
         elsif input == 'exit'
            exit
         elsif input == (/^[0A-Za-z5-9].*/i)
            puts ""
            puts "Enter valid input"
            puts ""
            menu
        end
    end

    def list_hikes
        LaHikes::Hike.all.drop(2).sort{|a, b| a.name <=> b.name}.each.with_index(1) do |hike, index|
            puts "#{index}. #{hike.name.gsub(/\#[0-9a-z]*/i, "")} - #{hike.distance}"
        end
    end

    def list_location
        LaHikes::Hike.all.drop(2).collect {|hike| hike.location}.uniq.sort.each.with_index(1) do |location, index|
            puts "#{index}. #{location}"
        end
    end

    def list_difficulty
        puts "1. Easy"
        puts "2. Intermediate"
        puts "3. Difficult"
    end

    def select_hike(num)
            puts ""
            hikes = LaHikes::Hike.all.drop(2).sort{|a, b| a.name <=> b.name}
            selected = hikes[num-1]
            puts ""
            puts "#{selected.name.gsub(/\#[0-9a-z]*/i, "")}"
            puts "#{selected.location}"
            puts "#{selected.distance}"
            puts "#{selected.difficulty}"
            puts "#{selected.url}"
            puts ""
        
    end

    def select_hike_by_location(num)
        locations = LaHikes::Hike.all.drop(2).collect {|hike| hike.location}.uniq.sort
        selected = locations[num-1]
        hikes = LaHikes::Hike.all.drop(2).sort{|a, b| a.name <=> b.name}

        hikes.collect.each.with_index(1) do |hike, index| 
            if hike.location == selected
                puts "#{index}. #{hike.name.gsub(/\#[0-9a-z]*/i, "")} - #{hike.location}" 
            end
        end
        puts ""
    end

    def select_hike_by_difficulty(num)
        hikes = LaHikes::Hike.all.drop(2).sort{|a, b| a.name <=> b.name}
        if num == 1
            hikes.each.with_index(1).collect {|hike, index| 
                puts "#{index}. #{hike.name.gsub(/\#[0-9a-z]*/i, "")} - #{hike.location} - #{hike.difficulty}" if hike.difficulty == 'Easy'}
        elsif num == 2
            hikes.each.with_index(1).collect {|hike, index| 
                puts "#{index}. #{hike.name.gsub(/\#[0-9a-z]*/i, "")} - #{hike.location} - #{hike.difficulty}" if hike.difficulty == 'Intermediate'}
        elsif num == 3
            hikes.each.with_index(1).collect {|hike, index| 
                puts "#{index}. #{hike.name.gsub(/\#[0-9a-z]*/i, "")} - #{hike.location} - #{hike.difficulty}" if hike.difficulty == 'Difficult'}
        end
        puts ""
    end

    def difficulty_selector(num)
        length = LaHikes::Hike.all.drop(2).collect {|hike| hike.difficulty}.uniq.length
        if num.between?(1, length)
            select_hike_by_difficulty(num)
        elsif num == 311
            menu
        else
            puts ""
            puts "If you would like to return to the main menu, enter '311'"
            puts "Otherwise, please make a valid selection:"
            puts ""
            num = gets.to_i
            difficulty_selector(num)
        end
    end

    def hike_selector(num)
        length = LaHikes::Hike.all.drop(2).length
        if num.between?(1, length) 
            select_hike(num)
        elsif num == 311
            menu
        else
            puts ""
            puts "If you would like to return to the main menu, enter '311'"
            puts "Otherwise, please make a valid selection:"
            puts ""
            num = gets.to_i
            hike_selector(num)
        end
    end

    def location_selector(num)
        length = LaHikes::Hike.all.drop(2).collect {|hike| hike.location}.uniq.length
        if num.between?(1, length)
            select_hike_by_location(num)
        elsif num == 311
            menu
        else
            puts ""
            puts "If you would like to return to the main menu, enter '311'"
            puts "Otherwise, please make a valid selection:"
            puts ""
            num = gets.to_i
            location_selector(num)
        end
    end

    def random_hike
        length = LaHikes::Hike.all.drop(2).length
        select_hike(rand(length))
    end

    def return_to_menu?
        puts "Would you like to return to the menu? y/n"
        answer = gets.strip
        menu if answer == 'y'
    end

end
    


