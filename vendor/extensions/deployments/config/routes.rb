Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :deployments do
    resources :deployments, :path => '', :only => [:index, :show, :new, :create]
  end

  # Admin routes
  namespace :deployments, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :deployments, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
