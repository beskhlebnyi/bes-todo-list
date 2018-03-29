Rails.application.routes.draw do
  resources :lists do
    resources :tasks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'lists#index'

  get '/list-tasks/:id', to: 'lists#list_tasks', as: :render_tasks
end
