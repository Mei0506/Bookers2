Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'homes#top'
  get '/homes/about', to: 'homes#about', as: :about
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :edit, :index, :update, :destroy, :change]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
