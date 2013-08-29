  module ApplicationHelper

    def bookmarker(bookmark_url)
      raise "give the path for bookmarker" unless bookmark_url.present?
      b = Bookmarker::Bookmark.for_user_and_path(current_user, request.env['PATH_INFO'])
      render partial: '/bookmarker/bookmarker', locals: { bookmark_url: bookmark_url, b: b }
    end

  end
