Rails.application.routes.draw do
    get '/' , to: 'application#index'
    resources :users, :only => [:new,:create]
    resources :sessions, :only => [:new,:create]
    resources :notes, :only => [:index,:new,:show,:create,:update]
    resources :templates, :only => [:index,:new,:create]

    namespace :api do
        get 'questions/(:template_id)' , to: 'questions#show'
    end
end
