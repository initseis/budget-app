Rails.application.routes.draw do
  get 'groups/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :groups, except: [:delete] do
    resources :contracts, except: [:delete]
  end 
  root to: "groups#index"
end
