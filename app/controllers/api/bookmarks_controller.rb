class Api::BookmarksController < ApplicationController
  respond_to :json

  def index
    render json: Bookmark.all
  end

  def metadata
    render json: PageScrapper.new(params[:url])
  end

  def search
    bookmarks = Bookmark
    query = parse_query params[:query]

    bookmarks = bookmarks.tagged_with(query[:tag]) if query[:tag]

    %i(description title url).each do |type|
      if query[type].present?
        sql_query = query[type].map { |q| "#{type} LIKE ?" }.join(' OR ')
        bookmarks = bookmarks.where(sql_query, *query[type].map { |q| "%#{q}%"})
      end
    end
    query[:text] = "%#{query[:text]}%"
    bookmarks = bookmarks.where('description LIKE ? or title LIKE ? or url LIKE ?', query[:text], query[:text], query[:text]) if query[:text]
    render json: bookmarks
  end

  def show
    render json: Bookmark.find(params[:id])
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

  def parse_query(query)
    query_tree = {}

    query_tree[:text] = query.gsub(/\s+(tag|title|description):[^ ]+/i) do |match|
      type, content = match.split(':', 2)
      type = type.strip.downcase.to_sym
      if type.in? %i(tag title description url)
        query_tree[type] ||= []
        query_tree[type] << content.gsub('%', '\%')
      end
      ''
    end

    query_tree
  end
end
