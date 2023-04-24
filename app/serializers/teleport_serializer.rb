class TeleportSerializer
  attribute :title, :min, :max
  
  def min
    object[:salary_percentiles][:percentile_25].to_s.prepend('$')
  end

  def max
    object[:salary_percentiles][:percentile_75].to_s.prepend('$')
  end
end