class ComicsController < ApplicationController
  before_action :set_comic, only: [:show, :update, :destroy]

  # GET /comics
  def index
    @comics = Comic.all

    render json: @comics
  end

  # GET /comics/1
  def show
    render json: @comic
  end


  # PATCH/PUT /comics/1
  def update
    if @comic.update(comic_params)
      render json: @comic
    else
      render json: @comic.errors, status: :unprocessable_entity
    end
  end


  def toggle
    @comic = Comic.find(params[:id])

    case params[:comic][:vote_type]
    when 'upvote' 
      @comic.increment!(:upvote)
    when 'downvote'
      @comic.increment!(:downvote)
    end

    render json: @comic
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comic
      @comic = Comic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comic_params
      params.require(:comic).permit(:title, :image_url)
    end
end
