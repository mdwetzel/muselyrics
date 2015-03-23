Rails.application.routes.draw do

  root 'albums#index'

  devise_for :users

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
