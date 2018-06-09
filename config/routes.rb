Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  resources :lists do
    resources :tasks
  end

  root to: 'lists#main_page'
end
