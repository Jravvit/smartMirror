class Weather < ActiveRecord::Base
  belongs_to :area

  def self.insert_today_weather(x, y)
    require 'weather_cast'
    today_weather_casts = WeatherCast.parser(x,y)

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

  def self.insert_today_weather_cron
    require 'weather_cast'
    @area = Area.last

    today_weather_casts = WeatherCast.parser(@area.x,@area.y)

    date = today_weather_casts[:date]

    today_weather_casts[:data].each do |w|
      weather = Weather.new
      weather.date = date
      weather.state = w[:state]
      weather.hour = w[:hour]
      weather.temp = w[:temp]
      weather.image = w[:image]
      weather.area_id = @area.id
      weather.save
    end
    today_weather_casts
  end

end
