Rails.application.routes.draw do
  resources :lists do
    resources :tasks
  end

  root to: 'lists#main_page'
end
