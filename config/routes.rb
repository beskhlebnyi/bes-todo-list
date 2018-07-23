Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do    
    devise_for :users, controllers: {
      passwords:     'users/passwords',
      registrations: 'users/registrations',
      sessions:      'users/sessions'
    }

    resources :lists do
      resources :files
    end

    get 'search/index'
    get 'shared_list/index'
    root to: 'lists#main_page'
  end
end
