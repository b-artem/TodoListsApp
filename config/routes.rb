Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :todo_lists, shallow: true do
    resources :tasks do
      member do
        patch 'priority_up', 'priority_down', 'change_state'
      end
    end
  end

  root 'todo_lists#index'
  get 'signup'  => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
