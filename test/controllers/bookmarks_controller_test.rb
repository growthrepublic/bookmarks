require 'test_helper'

describe Api::BookmarksController do
  describe '#new' do
    it do
      get :new
      assert_select 'form #bookmark_url'
    end
  end

  describe '#create' do
    it do # valid
      post :create, {bookmark: {url: 'http://www.google.pl'}}
      assert_redirected_to api_bookmark_path(Bookmark.last)
    end

    it do # invalid
      post :create, {bookmark: {url: ''}}
      assert_select '.has-error'
    end
  end

  describe '#edit' do
    let (:bookmark) {
      Bookmark::Create[bookmark: {
          url: 'http://www.google.pl',
          title: 'Google Search Engine'
      }].model
    }

    it do
      get :edit, id: bookmark.id
      assert_select 'form'
    end
  end
end
