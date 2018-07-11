Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  scope "(:locale)", locale: /en|ru/ do    
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      passwords:     'users/passwords',
      registrations: 'users/registrations',
      sessions:      'users/sessions',
    }

    resources :lists do
      resources :tasks
    end

    root to: 'lists#main_page'
  end
end
