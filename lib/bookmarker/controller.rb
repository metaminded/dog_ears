module Bookmarker
  module Controller

    def index
      @bookmarks = Bookmarker::Bookmark.for_user(current_user).where(level: params[:level])
      render json: @bookmarks.to_json
    end

    def create
      path = params[:path]
      title = params[:title]
      title = nil if title == 'null'
      user = current_user
      render json: Bookmarker.bookmark(user, path, title).to_json
    end

    def destroy
      @bookmark = Bookmarker::Bookmark.for_user(current_user).find(params[:id])
      @bookmark.destroy
      render json: 'destroyed'.to_json
    end

  end
end
