class PageScrapper
  extend Memoist

  ATTRIBUTES = %w(title description tags)

  def initialize(url)
    @url = url
  end

  def title
    scrapper.best_title || URI.parse(@url).host
  end
  memoize :title

  def description
    scrapper.description
  end
  memoize :description

  def tags
    # TODO: MORE COMPLEXITY!
    tags = []
    tags += scrapper.meta['keywords'].to_s.split(',').map(&:strip)
    tags += AlchemyAPI.search(:keyword_extraction, url: @url).reduce([]) do |keywords, keyword|
      keywords << keyword['text'] if keyword['relevance'].to_f < 0.7
      keywords
    end
    tags.uniq
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
end