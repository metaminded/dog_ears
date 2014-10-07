#--
# Copyright (c) 2010-2014 Peter Horn metaminded UG
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

module DogEars
  module Controller

    def index
      @bookmarks = DogEars::Bookmark.for_user(current_user).where(level: params[:level])
      render json: @bookmarks.to_json
    end

    def create
      path = params[:path]
      title = params[:title]
      level = Bookmark::LEVELS[params[:level].to_i]
      title = nil if title == 'null'
      user = current_user
      b = DogEars.bookmark(user, path, title, level)
      render partial: '/dog_ears/dog_ears',
        locals: { bookmark_url: '', b: b, path: b.path, method: 'GET' }
    end

    def get_users
      uu = User.where('id <> ?', current_user.id)
      render json: uu.inject({}){|a,e| a[e.id] = e.name; a }.to_json
    end

    def destroy
      @bookmark = DogEars::Bookmark.for_user(current_user).find(params[:id])
      @bookmark.destroy
      render partial: '/dog_ears/dog_ears',
        locals: { bookmark_url: '', b: nil, path: @bookmark.path, method: 'GET' }
    end

    def share
      @bookmark = DogEars::Bookmark.for_user(current_user).find(params[:id])
      user = User.find(params[:user_id])
      nb = @bookmark.dup
      nb.title = "[#{current_user.name}] #{nb.title}"
      nb.user_id = user.id
      nb.save!
      render partial: '/dog_ears/dog_ears',
        locals: { bookmark_url: '', b: @bookmark, path: @bookmark.path, method: 'GET' }
    end

  end
end
