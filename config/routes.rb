Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  post 'transfer' => 'transfer#create'

  get 'home/transfers' => 'home#transfers'
  get 'home/user_information' => 'home#user_information'

  root to: 'home#index'
end
