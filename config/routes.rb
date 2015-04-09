Rails.application.routes.draw do

  get 'sitemaps/show'

  root 'static_pages#home'

  resources :messages, only: [:index, :new, :create]

  get "/contact", to: "messages#index", as: "contact"

  get '/about', to: 'static_pages#about', as: 'about'
  get '/profile', to: 'users#profile', as: 'self_profile'
  get '/profile/:id', to: 'users#profile', as: 'user_profile'

  get '/sitemap.xml.gz' => 'sitemaps#show'

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
end
