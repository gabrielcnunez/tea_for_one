Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/v1/customers/:customer_id/subscriptions', to: 'api/v1/subscriptions#index'
  post '/api/v1/customers/:customer_id/subscriptions', to: 'api/v1/subscriptions#create'
  patch '/api/v1/customers/:customer_id/subscriptions', to: 'api/v1/subscriptions#update'
end
