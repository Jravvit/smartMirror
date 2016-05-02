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
      @area = Area.last
      @weather = @area.weathers.insert_today_weather @area.x, @area.y

      if @weather
        render json: "success"
      else
        render json: "failed"
      end
    end

    def today
      #@weather = Weather.where("date = ? and hour = ?",get_today_date, get_current_hour)
      @area = Area.last
      @weather = @area.weathers.where("date = ? and hour = ?",get_today_date, get_current_hour)
      #@weather = @area.weathers.last
      render json: @weather
    end

    def locale

    end

    def get_today_date
      time= Time.new
      today = time.strftime("%Y-%m-%d")
    end

    def get_current_hour
      time = Time.new
      hour = (time.hour/3)*3+3
    end

  end

end