Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do    
    devise_for :users, controllers: {
      passwords:     'users/passwords',
      registrations: 'users/registrations',
      sessions:      'users/sessions',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

    resources :lists do
      resources :tasks
    end

    root to: 'lists#main_page'
  end
end
