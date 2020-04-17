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
            puts "Select a hike:"
            num = gets.to_i
            select_hike(num)
            return_to_menu?
         elsif input == '3'
            puts ""
            list_difficulty
            puts ""
            puts "Select difficulty level from the menu:"
            num = gets.to_i
            difficulty_selector(num)
            return_to_menu?
         elsif input == '4'  
            random_hike
         elsif input == 'exit' #.include?(/^[A-Z\W.*]/)
            exit
         elsif input.include?(/\W[a-z].*/i)
            "Enter valid input"
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
        LaHikes::Hike.all.drop(2).collect {|hike| hike.difficulty}.uniq.each.with_index(1) do |difficulty, index|
            puts "#{index}. #{difficulty}"
        end
    end

    def select_hike(input)
            puts ""
            hikes = LaHikes::Hike.all.drop(2).sort{|a, b| a.name <=> b.name}
            selected = hikes[input-1]
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
                puts "#{index}. #{hike.name.gsub(/\#[0-9a-z]*/i, "")}" 
            end
        end
        puts ""
    end

    def select_hike_by_difficulty(num)
        difficulty_level = LaHikes::Hike.all.drop(2).collect {|hike| hike.difficulty}.uniq.sort
        selected = difficulty_level[num-1]
        hikes = LaHikes::Hike.all.drop(2).sort{|a, b| a.name <=> b.name}

        hikes.collect.each.with_index(1) do |hike, index| 
            if hike.difficulty == selected
                puts "#{index}. #{hike.name.gsub(/\#[0-9a-z]*/i, "")}" 
            end
        end
        puts ""
    end

    def difficulty_selector(num)
        length = LaHikes::Hike.all.drop(2).collect {|hike| hike.difficulty}.uniq.length
        if num.between?(1, length)
            select_hike_by_difficulty(num)
        else
            puts "Please make a valid selection:"
            num = gets.to_i
            difficulty_selector(num)
        end
    end

    def hike_selector(num)
        length = LaHikes::Hike.all.drop(2).length
        if num.between?(1, length) 
            select_hike(num)
        else
            puts "Please make a valid selection:"
            num = gets.to_i
            hike_selector(num)
        end
    end

    def location_selector(num)
        length = LaHikes::Hike.all.drop(2).collect {|hike| hike.location}.uniq.length
        if num.between?(1, length)
            select_hike_by_location(num)
        else
            puts "Please make a valid selection:"
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
    


