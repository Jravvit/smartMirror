class YoutubeApi
    attr_accessor :api_key, :query, :max_result, :part
    attr_reader :next_page, :prev_page, :title, :thumbnail, :video_id

    YOUTUBE_API_URL= "https://www.googleapis.com/youtube/v3/search?"
    FIELDS = "fields=nextPageToken,prevPageToken,items(id(videoId),snippet(title,description,thumbnails(medium)))"
    PART = "snippet"

    def initialize(api_key)
      @api_key = api_key
      @youtube_api = nil
      @query = nil
      @max_result = 5
      @next_page = nil
      @prev_page = nil
      @title = Array.new
      @thumbnail = Array.new
      @video_id = Array.new
      @first_page = nil
    end

    def item_parser json_list
      #parsing to get list
      #title, thumbnail - midium, videoId, nextPageToken, prevPageToken

      list_info = Hash.new()

      json_list.each do |key, value|
        if key.eql?"nextPageToken" then
          list_info[:nextPageToken] = value;@next_page = value;
          if @first_page.nil? then
            @first_page = value
          end
        end
        if key.eql?"prevPageToken" then list_info[:prevPageToken] = value;@prev_page= value end


        if key.eql?"items"
          list_info[:items] = []
          value.each do |item|
            item_info = Hash.new
            if item["id"].nil? then next end
            item_info[:video_id] = item["id"]["videoId"]
            item_info[:title] = item["snippet"]["title"]
            item_info[:description] = item["snippet"]["description"]
            item_info[:thumbnail] =item["snippet"]["thumbnails"]["medium"]

            list_info[:items].push item_info
          end
        end
      end

      list_info
    end

    def get query: @query, max_result: @max_result, page_token: nil, type: nil
      #set api options and return option values

      api_query = set_query query: query, max_result: max_result, page_token: page_token, type: type

        puts  api_query
      json_list = get_list @youtube_api

      if type.eql?"raw"
        return json_list
      else
        item_parser json_list
      end
    end

    def set_query query: @query, max_result: @max_result, page_token: nil, type: nil

      @youtube_api = YOUTUBE_API_URL.clone
      @youtube_api.concat "part=#{PART}+"
      @youtube_api.concat "&q=#{query}"
      @youtube_api.concat "&maxResults=#{max_result+1}"
      @youtube_api.concat "&pageToken=#{page_token}"
      set_options query, max_result

      return youtube_api
    end

    def set_options query, max_result
      if !@query.eql?query then @query = query end
      if !@max_result.eql?max_result then  @max_result = max_result end
    end



    def get_list api_query
      JSON.parse(Mechanize.new.get("#{api_query}&key=#@api_key&#{FIELDS}").body)
    end

    def get_next_list
      get page_token: @next_page
    end

    def get_prev_list
      #get previous list
      get page_token: @prev_page
    end

    def get_first_list
      get page_token: @first_page
      get_prev_list
    end

    def get_full_json
      #get current json not parsing
    end
  end