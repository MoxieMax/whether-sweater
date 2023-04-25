class Activities
  attr_reader :id,
              :activities,
              :destination,
              :forecast
  
  def initialize(data)
    # binding.pry
    @id          = nil
    @activities  = data[:activities]
    @destination = data[:destination]
    # binding.pry
    @forecast    = { "summary" => data[:forecast_summary], "temperature" => data[:temperature],}
    # binding.pry
  end
end