Rails.application.routes.draw do

  devise_for :admins
  resources :posts
  resources :pages
  resources :inquiries, except: [:new]

  root 'basic_page#index'
  match '/about',       to: 'basic_page#about',         via: 'get'
  match '/admin',       to: 'basic_page#admin',         via: 'get'
  match '/hire_me',     to: 'inquiries#new',            via: 'get'
  match '/blog',        to: 'posts#index',              via: 'get'
end
