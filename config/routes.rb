Rails.application.routes.draw do
   root to: 'home#index'
   namespace :api do
	  resources :questions, only: %i(show)
   end
end
