Rails.application.routes.draw do

  devise_for :admins
  resources :posts do
    # Renders unsaved Markdown for the editor's Preview tab.
    post :preview, on: :collection
  end
  resources :collections

  root 'basic_page#index'
  
  get '/admin',           to: 'basic_page#admin'
  get '/resume',          to: 'basic_page#resume'
  get '/blog',            to: 'posts#index'

  # Must sit above the catch-all below, or it is never reached.
  get "up" => "rails/health#show", as: :rails_health_check

  get '*path' => redirect { |p, req|
    req.flash[:notice] = "#{p[:path]} is unavailable";
   '/'
  }
end
