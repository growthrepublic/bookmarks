class Api::BookmarksController < ApplicationController
  respond_to :html, :json

  def new
    form Bookmark::Create
  end

  def create
    run Bookmark::Create do |op|
      return redirect_to [:api, op.model]
    end

    render action: :new
  end

  def show
    present Bookmark::Update
  end

  def edit
    form Bookmark::Update

    render action: :new
  end

  def update
    run Bookmark::Update do |op|
      return redirect_to [:api, op.model]
    end

    render action: :new
  end
end
