class Bookmark < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    model Bookmark, :create

    contract do
      property :url
      property :title
      property :description

      validates :url, presence: true
    end

    def process(params)
      validate(params[:bookmark]) do |f|
        f.save
      end
    end
  end

  class Update < Create
    action :update
  end
end