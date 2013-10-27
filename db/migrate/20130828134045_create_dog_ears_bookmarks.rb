class CreateDogEarsBookmarks < ActiveRecord::Migration
  def change
    create_table :dog_ears_bookmarks do |t|
      t.references :user
      t.text :path
      t.text :title
      t.text :comment
      t.string :level
      t.timestamps
    end
  end
end
