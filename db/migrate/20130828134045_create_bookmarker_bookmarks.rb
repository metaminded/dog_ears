class CreateBookmarkerBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarker_bookmarks do |t|
      t.references :user
      t.text :path
      t.text :title
      t.text :comment
      t.string :level
      t.timestamps
    end
  end
end
