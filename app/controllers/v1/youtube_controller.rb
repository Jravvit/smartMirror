module V1
  class YoutubeController < BaseController
    require "youtube_api"

    def index
      render json: get_list
    end

    def get_list
      api_key = "AIzaSyBPExXnsihvNXQ6Px_kmqipb3bnshlnCCE"

      @test = YoutubeApi.new(api_key)
      @test.get query: "메이크업", max_result: 10
    end
  end


end