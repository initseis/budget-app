Rails.application.routes.draw do
  get 'groups/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :groups, except: [:delete, :update] do
    resources :contracts, except: [:delete, :update]
  end 
  root to: "groups#index"
end
