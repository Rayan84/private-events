Rails.application.routes.draw do
  root 'events#index'
  get 'users/sign_in', to: 'users#sign_in'
  put 'users/sign_in', to: 'users#logged_in'
  put 'events/add/:id', to: 'events#add'
  delete 'users/log_out', to: 'users#log_out'
  resources :users, only: %i[new create show]
  resources :events

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
