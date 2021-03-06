Rails.application.routes.draw do
  root 'pages#home'
  get '/home' => 'pages#home'

  resources :recipes do
    member do
      post 'like'
    end
  end
  resources :users, except: [:new, :destroy]

  get '/register' => 'users#new'

  get '/login' => 'logins#new'
  post '/login' => 'logins#create'
  get '/logout' => 'logins#destroy'

  resources :styles, only: [:new, :create, :show]
  resources :ingredients, only: [:new, :create, :show]
end
