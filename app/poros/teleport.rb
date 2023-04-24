class Teleport
  attr_reader :id,
              :jobs
  
  def initialize(data)
    # binding.pry
    @id = nil
    @jobs = job_info(data)
    # binding.pry
  end
  
  def job_info(info)
    info.map do |job|
        # binding.pry
      {
        title: job[:job][:title],
        min: job[:salary_percentiles][:percentile_25].round(2).to_s.prepend('$'),
        max: job[:salary_percentiles][:percentile_75].round(2).to_s.prepend('$')
      }
    end
  end
end