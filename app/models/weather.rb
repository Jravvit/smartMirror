class Weather < ActiveRecord::Base

  def insert_today_weather
    today_weather_casts = WeatherCast::parser

    date = today_weather_casts[:date]

    today_weather_casts[:data].each do |w|
      weather = Weather.new
      weather.date = date
      weather.state = w[:state]
      weather.hour = w[:hour]
      weather.temp = w[:temp]
      weather.image = w[:image]
      weather.save
    end
    today_weather_casts
  end

  def get_today_date
    time= Time.new
    today = time.strftime("%Y-%m-%d")
  end

  def get_current_hour
    time = Time.new
    hour = (time.hour/3)*3
  end

end
