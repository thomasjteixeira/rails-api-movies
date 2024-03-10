Rails.application.routes.draw do
  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create destroy]
  resources :movies, only: %i[index new create] do
    collection { post :import_movies }
  end

  resources :user_movies, only: %i[create update] do
    collection { post :import_movie_scores }
  end

  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  root 'sessions#new'
end
