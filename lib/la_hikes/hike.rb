class LaHikes::Hike
    attr_accessor :name, :location, :distance, :difficulty, :url
    
    @@all = []
    
    def self.new_from_scrape(hike_name)
        hike = self.new
        hike.name = hike_name.css("a strong").text
        hike.distance = hike_name.css("td.hidden-sm-down span.imperial").text.split(" ").join(" ")
        hike.difficulty = hike_name.css("td.hidden-sm-down span.difficulty-text").text
        hike.location = hike_name.css("div.float-xs-right").text.split(" ").join(" ")
        hike.url = hike_name.css("td a").attribute("href")
        @@all << hike
    end
    
    def self.all
        @@all
    end
   
end
    