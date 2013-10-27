module DogEarsHelper

  def dog_ears(bookmark_url)
    raise "give the path for dog_ears" unless bookmark_url.present?
    b = DogEars::Bookmark.for_user_and_path(current_user, request.env['PATH_INFO'])
    render partial: '/dog_ears/dog_ears', locals: { bookmark_url: bookmark_url, b: b }
  end

end
