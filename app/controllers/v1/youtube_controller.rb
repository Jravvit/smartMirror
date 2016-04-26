module V1
  class YoutubeController < BaseController

    $api_key = "AIzaSyBPExXnsihvNXQ6Px_kmqipb3bnshlnCCE"

    def index
      render json: get_list
    end

    def get_list

      @test = YoutubeList.new($api_key)
      @test.query = "메이크업"
      @test.options

    #  v = JSON.parse(Mechanize.new.get("https://www.googleapis.com/youtube/v3/search?part=snippet+&q=123&maxResults=10&key=#$api_key").body)
    end
  end

  class YoutubeList
    attr_accessor :api_key, :query, :max_result, :part
    attr_reader :next_page, :prev_page, :title, :thumbnail, :video_id

    def initialize(api_key)
      @api_key = api_key
      @youtube_api = "https://www.googleapis.com/youtube/v3/search?"
      @query = nil
      @max_result = 5
      @part = "snippet"
      @next_page = nil
      @prev_page = nil
      @title = Array.new
      @thumbnail = Array.new
      @video_id = Array.new
    end

    def item_parser
      #parsing to get list
      #title, thumbnail - midium, videoId, nextPageToken, prevPageToken
    end

    def options query: @query, max_result: @max_result, part: @part
      #set api options and return option values

      @youtube_api.concat "part=#{part}+"
      @youtube_api.concat "&q=#{query}"
      @youtube_api.concat "&maxResults=#{max_result}"

      set_options query, max_result, part

      get_list @youtube_api
    end
    
    def set_options query, max_result,part
      if !@part.eql?part then @part = part end
      if !@query.eql?query then @query = query end
      if !@max_result.eql?max_result then  @max_result = max_result end
    end

    def get_list api_query
      #get youtube api list
      puts api_query
      JSON.parse(Mechanize.new.get("#{api_query}&key=#@api_key").body)
    end

    def get_next_list
      #get next list
    end

    def get_prev_list
      #get previous list
    end

    def get_full_json
      #get current json not parsing
    end
  end

end