class Bookmark::Cell < Cell::Concept
  property :url
  property :title
  property :description

  def show
    render
  end
end
