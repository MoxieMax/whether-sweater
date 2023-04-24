class TeleportService
  def self.get_urban_area(name)
    get_data("urban_areas/slug:#{urban_area}/")
  end
  
  def self.get_salaries(urban_area)
    get_data("urban_areas/slug:#{urban_area}/salaries/")
  end
  
  def self.get_data(url)
    response = conn.get(url)
    
    binding.pry
    
    JSON.parse(response.body, symbolize_names: true)
  end

private

  def self.conn
    Faraday.new(
      url: "https://api.teleport.org/api/",
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end