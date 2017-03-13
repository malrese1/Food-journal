Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Good job setting up a root route and using nested resources appropriately
  root to: "posts#index"
  resources :posts do
    resources :comments
  end
end
