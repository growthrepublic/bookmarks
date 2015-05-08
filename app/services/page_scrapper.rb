class PageScrapper
  extend Memoist

  ATTRIBUTES = %w(title description tags)

  def initialize(url)
    @url = url
  end

  def title

  end
  memoize :title

  def description

  end
  memoize :description

  def tags

  end
  memoize :tags

  def as_json
    ATTRIBUTES.map { |attribute| send(attribute) }
  end

  def to_json
    as_json.to_s
  end

  protected
  def scrapper
    MetaInspector.new(@url)
  end
  memoize :scrapper

  def alchemy

  end
  memoize :alchemy
end