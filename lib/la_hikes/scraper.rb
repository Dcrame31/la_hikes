class LaHikes::Scraper

    def get_page
        Nokogiri::HTML(open('https://www.hikingproject.com/directory/8007309/san-gabriel-mountains'))
    end

    def scrape_hikes
        self.get_page.css("tr")
    end

    def make_hikes
        scrape_hikes.each do |hike|
        LaHikes::Hike.new_from_scrape(hike)
        end
    end

end


