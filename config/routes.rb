Workarea::Admin::Engine.routes.draw do
  scope '(:locale)', constraints: Workarea::I18n.routes_constraint do
    namespace :listrak do
      resource :configuration, only: [:edit, :update]
      resources :lists, only: [] do
        resources :events, only: :index
      end
    end
  end
end
