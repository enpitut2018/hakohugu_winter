Rails.application.routes.draw do
    get '/' , to: 'application#index'
    resources :users, :only => [:new,:create]
    resources :sessions, :only => [:new,:create]
    resources :documents, :only => [:index,:new,:show,:create,:update,:destroy]
    resources :templates, :only => [:index,:new,:show,:create,:edit,:update,:destroy]

    namespace :api do
        get 'questions/(:document_id)' , to: 'questions#show'
    end
end
