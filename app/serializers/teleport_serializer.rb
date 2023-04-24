class TeleportSerializer
  include JSONAPI::Serializer
  attribute :title, :min, :max
  
  # def initialize(salaries, job_titles = nil)
  #   @salaries = salaries
  #   @job_titles = job_titles
  # end
  
  def min
    binding.pry
    object[:salary_percentiles][:percentile_25].to_s.prepend('$')
  end

  def max
    object[:salary_percentiles][:percentile_75].to_s.prepend('$')
  end
end