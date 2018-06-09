Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions'
  }
  
  resources :lists do
    resources :tasks
  end

  root to: 'lists#main_page'
end
