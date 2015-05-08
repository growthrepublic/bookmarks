class AddThumbnailToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :thumbnail, :string
  end
end
