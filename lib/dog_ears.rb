require "dog_ears/engine"
require "dog_ears/controller"
require "dog_ears/rails/routes"
require "dog_ears/rails/helper"

module DogEars

  def self.bookmark(user, path, title, level=nil)
    b = Bookmark.new do |b|
      b.user = user
      b.path = path
      b.title = title.presence || path
      b.level = level
    end
    b.save!
    b
  end

end
