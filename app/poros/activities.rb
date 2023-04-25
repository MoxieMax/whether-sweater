class Activities
  attr_reader :id,
              :activities,
              :destination,
              :forecast
  
  def initialize(data)
    @id          = nil
    @activities  = data[:activities]
    @destination = data[:destination]
    @forecast    = { "summary" => data[:forecast_summary], "temperature" => data[:temperature],}
  end
end