class BookmarksController < ApplicationController
  respond_to :html

  def new
    form Bookmark::Create
  end

  def create
    run Bookmark::Create do |op|
      return redirect_to op.model
    end

    render action: :new
  end
end
