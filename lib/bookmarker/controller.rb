module Bookmarker
  module Controller

    def index
      @bookmarks = Bookmarker::Bookmark.for_user(current_user).where(level: params[:level])
      render json: @bookmarks.to_json
    end

    def create
      path = params[:path]
      title = params[:title]
      level = Bookmark::LEVELS[params[:level].to_i]
      title = nil if title == 'null'
      user = current_user
      b = Bookmarker.bookmark(user, path, title, level)
      render partial: '/bookmarker/bookmarker',
        locals: { bookmark_url: b.path, b: b, path: b.path, method: 'GET' }
    end

    def destroy
      @bookmark = Bookmarker::Bookmark.for_user(current_user).find(params[:id])
      @bookmark.destroy
      render partial: '/bookmarker/bookmarker',
        locals: { bookmark_url: , b: nil, path: @bookmark.path, method: 'GET' }
    end

  end
end
