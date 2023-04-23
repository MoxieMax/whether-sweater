require 'rails_helper'

describe WeatherService do
  context "instance methods" do
    it '' do
      ws = WeatherService.get_forecast("Cincinnati, OH")
      # Cincinnati {:lat=>39.103119, :lng=>-84.512016}
    end
  end
end