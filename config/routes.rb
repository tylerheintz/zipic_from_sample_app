SampleApp::Application.routes.draw do
  resources :comments

  resources :tags

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :sessions,      only: [:new, :create, :destroy]
  
  resources :microposts,    only: [:create, :destroy, :update, :rateup, :ratedown, :show]
  
  resources :relationships, only: [:create, :destroy]
  root to: 'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/top_rated', to: 'static_pages#top_rated', via: 'get'
  match '/mixer', to: 'static_pages#mixer', via: 'get'
end
