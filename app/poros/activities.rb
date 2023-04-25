class Activities
  attr_reader :activities
  
  def initialize(data)
    # binding.pry
    @activities = activities_hash(data)
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