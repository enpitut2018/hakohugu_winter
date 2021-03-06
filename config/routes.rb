Rails.application.routes.draw do
    get '/' , to: 'sessions#new'
    resources :users
    post '/users/new',  to: 'users#create'
    resources :sessions, :only => [:new,:create]
  
    get 'documents/open' => 'documents#open'
    get 'documents/assistant' => 'documents#assistant'
    resources :documents do 
      member do
        get 'release'
        get 'read'
        post 'test'
      end
    end
  
    resources :templates do
      member do
        get 'release'
      end
      collection do
      get 'category_auto_complete'
      get 'template_auto_complete'
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

    get '/help', to: 'application#help'
end
