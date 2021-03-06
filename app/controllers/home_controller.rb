class HomeController < ApplicationController
  def index
  end

  def list
    respond_to do |format|
      format.html { render :list, locals: { bookmarks: fixtures } }
      format.json { render json: fixtures }
    end
  end

  def fixtures
    [
        {
            id: 1,
            url: 'http://google.com',
            title: 'Google.com',
            description: 'Search engine',
            tags: %w(search-engine google),

            thumbnail: '/mockup/httpgooglecom.png'
        },
        {
            id: 2,
            url: 'http://facebook.com',
            title: 'Facebook',
            description: 'Social media network, lorem ipsum dolor sit amet',
            tags: %w(social-media social-network friends photos),

            thumbnail: '/mockup/httpfacebookcom.png'
        },
        {
            id: 3,
            url: 'http://onet.pl',
            title: 'Onet.pl',
            description: 'Dzisiaj w Onet.pl: wiadomości z kraju i ze świata; biznes, sport, rozrywka i pogoda. Sprawdź pocztę, bloguj, czatuj i umawiaj się na randki.',
            tags: %w(news mail chat politics technology),

            thumbnail: '/mockup/httponetpl.png'
        }
    ]
  end
end
