class TeleportSerializer
  include JSONAPI::Serializer
  attribute :title, :min, :max
  
  # def initialize(salaries, job_titles = nil)
  #   @salaries = salaries
  #   @job_titles = job_titles
  # end
  
  # def min
  #   object[:salary_percentiles][:percentile_25].round(2).to_s.prepend('$')
  # end
  # 
  # def max
  #   object[:salary_percentiles][:percentile_75].round(2).to_s.prepend('$')
  # end
end