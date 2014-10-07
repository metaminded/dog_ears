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
