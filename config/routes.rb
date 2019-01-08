Rails.application.routes.draw do
    get '/' , to: 'sessions#new'
    resources :users
    post '/users/new',  to: 'users#create'
    resources :sessions, :only => [:new,:create]
    resources :documents, :only => [:index,:new,:show,:create,:update,:destroy]
    resources :templates do
      member do
        get 'release'
      end
    end
    resources :likes, only: [:create, :destroy]
    get    'login'   => 'sessions#new'
    post   'login'   => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'
    post 'templates/:id' => 'templates#index'


    namespace :api do
        get 'questions/(:document_id)' , to: 'questions#show'
    end
end
