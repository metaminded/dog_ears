module DogEars
  class Engine < ::Rails::Engine
    isolate_namespace DogEars
    initializer "dog_ears.view_helpers" do |app|
      ActionView::Base.send :include, ::DogEars::ViewHelpers
    end
  end
end
