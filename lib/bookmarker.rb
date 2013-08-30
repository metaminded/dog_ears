require "bookmarker/engine"
require "bookmarker/controller"
require "bookmarker/rails/routes"

module Bookmarker

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
