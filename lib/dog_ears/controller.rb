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
        locals: { bookmark_url: '', b: b, path: b.path, method: 'GET' }
    end

    def get_users
      uu = User.where('id <> ?', current_user.id)
      render json: uu.inject({}){|a,e| a[e.id] = e.name; a }.to_json
    end

    def destroy
      @bookmark = Bookmarker::Bookmark.for_user(current_user).find(params[:id])
      @bookmark.destroy
      render partial: '/bookmarker/bookmarker',
        locals: { bookmark_url: '', b: nil, path: @bookmark.path, method: 'GET' }
    end

    def share
      @bookmark = Bookmarker::Bookmark.for_user(current_user).find(params[:id])
      user = User.find(params[:user_id])
      nb = @bookmark.dup
      nb.title = "[#{current_user.name}] #{nb.title}"
      nb.user_id = user.id
      nb.save!
      render partial: '/bookmarker/bookmarker',
        locals: { bookmark_url: '', b: @bookmark, path: @bookmark.path, method: 'GET' }
    end

  end
end
