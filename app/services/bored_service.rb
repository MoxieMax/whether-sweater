class BoredService
  def self.get_random_activity
    #random event
    event = BoredService.get_data("activity/")
  end
  
  def self.get_activity(key) #string
    event = BoredService.get_data("activity?key=#{key}")
  end
  
  def self.get_activity_by_participants(number)
    event = BoredService.get_data("activity?participants=#{number}")
  end
  
  def self.get_activity_by_type(type)
    event = BoredService.get_data("activity?type=#{type}")
  end
  
  def self.get_activity_by_price(price) #float like 1.4
    event = BoredService.get_data("activity?price=#{price}")
  end
  
  def self.get_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
    def self.conn
      Faraday.new(url: "http://www.boredapi.com/api/")
    end
end

# def self.get_activity_price_range(min, max) #float like 1.4
#   event = BoredService.get_data("/activity?minprice=#{min}&maxprice=#{max}")
# end

# def self.get_activity_by_accessibility(float) #float like 1.4
#   event = BoredService.get_data("/activity?accessibility=#{float}")
# end

# def self.get_activity_accessibility_range(min, max) #float like 1.4
#   event = BoredService.get_data("/activity?minaccessibility==#{min}&maxaccessibility==#{max}")
# end