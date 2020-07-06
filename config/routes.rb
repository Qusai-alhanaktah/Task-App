Rails.application.routes.draw do

  devise_for :users
  # resources :users do
  #   member do
  #     get :confirm_email
  #   end
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  resources :tasks
  get '/tasks/:id/generate', to: 'tasks#generate', as: 'generate'
end
