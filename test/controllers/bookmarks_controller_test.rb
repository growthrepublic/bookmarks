require 'test_helper'

describe BookmarksController do
  describe '#create' do
    it do # valid
      post :create, {bookmark: {url: 'http://www.google.pl'}}
      assert_redirected_to bookmark_path(Bookmark.last)
    end

    it do # invalid
      post :create, {bookmark: {url: ''}}
      assert_select '.has-error'
    end
  end
end
