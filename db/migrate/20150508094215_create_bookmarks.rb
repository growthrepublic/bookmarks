class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url, null: false
      t.string :title
      t.text   :description

      t.timestamps null: false
    end
  end
end
