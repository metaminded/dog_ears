module Bookmarker
  class Bookmark < ActiveRecord::Base
    # attr_accessible :title, :body
    LEVELS = [nil, 'info', 'warning', 'important', 'success']
    validates_inclusion_of :level, in: LEVELS

    belongs_to :user

    scope :for_user, ->(user) { where(user_id: user.id) }

    def self.for_user_and_path(user,path)
      for_user(user).where(path: path).first
    end

    def self.count_by_levels
      cbl = group(:level).count
      LEVELS.inject({}) do |a,e|
        a[e] = cbl[e] if cbl[e] && cbl[e] > 0
        a
      end
    end
  end
end
