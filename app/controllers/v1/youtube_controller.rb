module V1
  class YoutubeController < BaseController
    require "youtube_api"

    def index
      render json: get_list
    end

    def get_list
      @test = YoutubeApi.new(params[:api_key])

      @test.get query: "컴퓨터", max_result: 8, page_token: params[:page]
    end

    def prev
      @test.get_prev_list
    end

    def next
      @test.get_next_list
    end

    def first
      @test.get_first_list
    end

    private
    def youtube_params
      params.require(:youtube).permit(:api_key,:page)
    end
  end


end