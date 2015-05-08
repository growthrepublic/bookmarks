class Api::BookmarksController < ApplicationController
  respond_to :json

  def index
    render json: Bookmark.all
  end

  def show
    render json: Bookmark.find(params[:id])
  end

  def metadata
    render json: PageScrapper.new(params[:url])
  end

  def create
    bookmark = Bookmark.create!(bookmark_create_params)
    render json: bookmark

  rescue ActiveRecord::RecordInvalid
    render json: bookmark.errors
  end

  def update
    bookmark = Bookmark.find(params[:id])
    bookmark.update!(bookmark_update_params)
    render json: bookmark

  rescue ActiveRecord::RecordInvalid
    render json: bookmark.errors
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy!
    render json: bookmark
  end

  protected
  def bookmark_create_params
    params.permit(:url, :title, :description)
  end

  def bookmark_update_params
    params.permit(:title, :description)
  end
end
