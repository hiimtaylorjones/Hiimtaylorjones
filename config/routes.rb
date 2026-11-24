Rails.application.routes.draw do

  # Admin login. Helper names match the old Devise routes.
  get    "login",  to: "admin_sessions#new",     as: :new_admin_session
  post   "login",  to: "admin_sessions#create",  as: :admin_session
  delete "logout", to: "admin_sessions#destroy", as: :destroy_admin_session

  resources :posts do
    # Renders unsaved Markdown for the editor's Preview tab.
    post :preview, on: :collection
  end
  resources :collections

  root 'basic_page#index'
  
  match '/admin',           to: 'basic_page#admin',   via: 'get'
  match '/resume',          to: 'basic_page#resume',  via: 'get'
  match '/blog',            to: 'posts#index',        via: 'get'

  # Must sit above the catch-all below, or it is never reached.
  get "up" => "rails/health#show", as: :rails_health_check

  get '*path' => redirect { |p, req|
    req.flash[:notice] = "#{p[:path]} is unavailable";
   '/'
  }
end
