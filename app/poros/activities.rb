class Activities
  attr_reader :id,
              :activities,
              :forecast
  
  def initialize(data)
    # binding.pry
    @id         = nil
    @activities = activities_hash(data)
    binding.pry
    # @forecast    = placeholder
    # binding.pry
  end
  
  def activities_hash(info)
    info.map do |activity|
      # binding.pry
      {
        "#{activity[:activity]}": {
          type: activity[:type],
          participants: activity[:participants],
          price: activity[:price]
        }
      }
    end
  end
end