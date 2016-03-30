module V1
  class WeathersController < BaseController

    # GET /weathers
    # GET /weathers.json
    def index
      @weathers = Weather.all

      render json: @weathers
    end

    # POST /weathers
    # POST /weathers.json
    def create
      @weather = insert_today_weather
      if @weather
        render json: "success"
      else
        render json: "failed"
      end
    end

    def today
      @weather = Weather.where("date = ? and hour = ?",get_today_date, get_current_hour)
      render json: @weather
    end

    def get_today_date
      time= Time.new
      today = time.strftime("%Y-%m-%d")
    end

    def get_current_hour
      time = Time.new
      hour = (time.hour/3)*3
    end

    def raw
      url = request.protocol+request.host_with_port+ActionController::Base.helpers.asset_path("clean.png")
      puts File.exist?(url)
    end

    def parser
      data_hash = Hash.from_xml(get_weathers)
      today_weather = Hash.new

      today_weather[:date] = data_hash['wid']['header']['tm'][0..7]
      today_weather[:data] = Array.new

      weather_states = {
          '맑음' => 'clean.svg',
          '구름' => 'cloud.svg',
          '비'   => 'rain.svg',
          '눈'   => 'snow.svg'
      }

      data_hash['wid']['body']['data'].each do |d|
        if d['day'] != '0' then break end
        weathers_json = Hash.new
        weathers_json[:hour] = d['hour']
        weathers_json[:state] = d['wfKor']
        weathers_json[:temp] = d['temp']

        weather_states.each do |key, value|
          if !d['wfKor'].index(key).nil? then weathers_json[:image] = value end
        end
        today_weather[:data].push(weathers_json)
      end
      today_weather
    end

    def insert_today_weather
      today_weather_casts = parser

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

    def get_weathers
      xml = Mechanize.new.get('http://www.kma.go.kr/wid/queryDFS.jsp?gridx=58&gridy=125').body
    end
  end

end