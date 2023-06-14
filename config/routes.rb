Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :movies, except: [:new] do
    collection {post :import}
  end
  root 'movies#index'
end
