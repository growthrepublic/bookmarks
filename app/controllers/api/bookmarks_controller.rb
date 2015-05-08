class Api::BookmarksController < ApplicationController
  respond_to :json

  def index
    render json: Bookmark.all
  end

  def metadata
    render json: PageScrapper.new(params[:url])
  end

  def create
    bookmark = Bookmark.create!(params.slice(:url, :title, :description))
    render json: bookmark

  rescue ActiveRecord::RecordInvalid
    render json: bookmark.errors
  end

  def update
    bookmark = Bookmark.find(params[:id])
    bookmark.update!(params.slice(:url, :title, :description))
    render json: bookmark

  rescue ActiveRecord::RecordInvalid
    render json: bookmark.errors
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy!
    render json: bookmark
  end
end
