require 'test_helper'

class BookmarkCrudTest < MiniTest::Spec
  describe "Create" do
    it "persists valid" do
      bookmark = Bookmark::Create[bookmark:
          {
              url: 'http://www.google.pl',
              title: 'Google Search Engine',
              description: ''
          }
      ]

      bookmark.persisted?.must_equal true
      bookmark.url.must_equal 'http://www.google.pl'
      bookmark.title.must_equal 'Google Search Engine'
      bookmark.description.must_equal ''
    end
  end
end