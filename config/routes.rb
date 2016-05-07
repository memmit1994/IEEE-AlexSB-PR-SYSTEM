Rails.application.routes.draw do
  
  resources :contacts
  devise_for :users

  root 'contacts#index'

  get 'static_pages/show'
  get 'static_pages/index'
  get 'static_pages/search'
  get 'contacts/search' => 'contacts#index'
end
