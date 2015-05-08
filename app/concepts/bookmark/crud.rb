class Bookmark < ActiveRecord::Base
  class Create < Trailblazer::Operation
    def process(params)
      Bookmark.create(params[:bookmark])
    end
  end
end