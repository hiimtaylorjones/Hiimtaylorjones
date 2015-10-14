Rails.application.routes.draw do

  devise_for :admins
  resources :posts
  resources :pages
  resources :inquiries

  root 'basic_page#index'
  match '/about',       to: 'basic_page#about',         via: 'get'
  match '/admin',       to: 'basic_page#admin',         via: 'get'
  match '/blog',        to: 'posts#index',              via: 'get'


end
