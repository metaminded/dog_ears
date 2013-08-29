require "bookmarker/engine"
require "bookmarker/controller"

module Bookmarker

  def self.bookmark(user, path, title, level=nil)
    b = Bookmark.new do |b|
      b.user = user
      b.path = path
      b.title = title.presence || path
    end
    b.save!
    b
  end

end
