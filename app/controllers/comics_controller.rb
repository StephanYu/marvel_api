class ComicsController < ApplicationController
  before_action :set_comic, only: [:show, :toggle, :update]

  def index
    @comics = Comic.all.order('created_at DESC')
  
    render json: @comics
  end

  def show
    render json: @comic
  end

  def search 
    if params[:query].blank?
      @comics = []
    else
      @comics = Comic.search(params[:query]).order("created_at DESC")
    end

    render json: @comics
  end

  def toggle
    case params[:comic][:vote_type]
    when 'upvote' 
      @comic.increment!(:upvote)
    when 'downvote'
      @comic.increment!(:downvote)
    end

    render json: @comic
  end

  private
    def set_comic
      @comic = Comic.find(params[:id])
    end

    def comic_params
      params.require(:comic).permit(:title, :image_url)
    end
end
