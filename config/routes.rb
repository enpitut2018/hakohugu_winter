Rails.application.routes.draw do
    get '/' , to: 'sessions#new'
    resources :users, :only => [:new,:create]
    post '/users/new',  to: 'users#create'
    resources :sessions, :only => [:new,:create]
    resources :documents, :only => [:index,:new,:show,:create,:update]
    resources :templates, :only => [:index,:new,:create]

    get    'login'   => 'sessions#new'
    post   'login'   => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'

    namespace :api do
        get 'questions/(:document_id)' , to: 'questions#show'
    end
end
