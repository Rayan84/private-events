Rails.application.routes.draw do
  get 'users/sign_in', to: 'users#sign_in'
  get 'users/logged_in', to: 'users#logged_in'
  resources :users, only: [:new, :create, :show]
  resources :events

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
