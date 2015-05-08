require 'test_helper'

class BookmarkCrudTest < MiniTest::Spec
  describe 'Create' do
    it 'persists valid' do
      bookmark = Bookmark::Create[bookmark:{
          url: 'http://www.google.pl',
          title: 'Google Search Engine',
          description: ''
      }].model

      bookmark.persisted?.must_equal true
      bookmark.url.must_equal 'http://www.google.pl'
      bookmark.title.must_equal 'Google Search Engine'
      bookmark.description.must_equal ''
    end

    it 'invalid' do
      res, op = Bookmark::Create.run(bookmark: {
          url: ''
      })

      res.must_equal false
      op.model.persisted?.must_equal false
      op.contract.errors.to_s.must_equal '{:url=>["can\'t be blank"]}'
    end
  end

  describe 'Update' do
    let (:bookmark) {
      Bookmark::Create[bookmark: {
          url: 'http://www.google.pl',
          title: 'Google Search Engine'
      }].model
    }

    it 'persists valid' do
      Bookmark::Update[
          id: bookmark.id,
          bookmark: {
              url: 'http://www.bing.com',
              title: 'Bing'
          }
      ]

      bookmark.reload
      bookmark.url.must_equal 'http://www.bing.com'
      bookmark.title.must_equal 'Bing'
    end
  end
end