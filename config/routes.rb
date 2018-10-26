Rails.application.routes.draw do
   get '/' , to: 'home#index'

   namespace :api do
	   get 'questions/(:template_id)' , to: 'questions#show'
   end
end
