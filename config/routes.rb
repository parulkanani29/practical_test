Rails.application.routes.draw do
  devise_for :users
  resources :home do
  	get :get_user_list, on: :collection
  end
  resources :appointments
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
