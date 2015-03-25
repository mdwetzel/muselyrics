Rails.application.routes.draw do

  root 'static_pages#home'

  devise_for :users

  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "register", to: "devise/registrations#new"
    get "logout", to: "devise/sessions#destroy"    
  end

  resources :articles
  resources :albums
  resources :songs
  resources :comments, except: [:new, :index, :show]

  resources :comments do
    member do
      put "like", to: "comments#upvote"
      put "dislike", to: "comments#downvote"
    end
  end

  resources :albums, except: [:new], path: '' do 
    resources :songs, except: [:index], path: ''
  end
  
  get '/about', to: 'static_pages#about', as: 'about'
  get '/contact', to: 'static_pages#contact', as: 'contact'
end
