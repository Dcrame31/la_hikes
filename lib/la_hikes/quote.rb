class LaHikes::Quote

    def self.random_quote
    
        quote_arr = 
        ["The mountains are calling and I must go", 
        "I took a walk in the woods and came out taller than trees.",
        "It’s not the mountain we conquer, but ourselves.",
        "After a day’s walk, everything has twice its usual value.",
        "There are no shortcuts to any place worth going.",
        "A walk in nature walks the soul back home.",
        "You’re off to great places, today is your day. Your mountain is waiting, so get on your way."]
    
        puts quote_arr[rand(7)]
    end

end
