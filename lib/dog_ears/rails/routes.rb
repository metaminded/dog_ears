require "active_support/core_ext/object/try"
require "active_support/core_ext/hash/slice"

module ActionDispatch::Routing
  class Mapper

    def dog_ears(options={})
      options[:as]          ||= @scope[:as]     if @scope[:as].present?
      options[:module]      ||= @scope[:module] if @scope[:module].present?
      options[:path_prefix] ||= @scope[:path]   if @scope[:path].present?
      options[:path_names]    = (@scope[:path_names] || {}).merge(options[:path_names] || {})
      options[:constraints]   = (@scope[:constraints] || {}).merge(options[:constraints] || {})
      options[:defaults]      = (@scope[:defaults] || {}).merge(options[:defaults] || {})
      options[:options]       = @scope[:options] || {}
      options[:options][:format] = false if options[:format] == false

      #puts "\n\n\n#{options.to_s}\n\n\n"

      resources :bookmarks, only: [:create, :destroy, :index] do
        collection do
          get :get_users
        end
        member do
          post :share
        end
      end

    end
  end
end
