Rails.application.routes.draw do

  get 'likes/create'

  devise_for :users , controllers: { registrations: "users/registrations" }

  root 'photos#index'
  match '/welcome', to: 'users#welcome', via: 'get'
  devise_scope :user do
    match '/signout', to: 'devise/sessions#destroy', via: 'delete'
    match '/login', to: 'devise/sessions#new', via: 'get'
  end

  resources :photos, only:[:new, :create, :index, :show] do
    post :like, on: :collection
    post :share, on: :collection
  end

  resources :users, only:[:refer] do
    post :refer, on: :member
  end

end
  