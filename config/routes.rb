Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  root "store#index", as: "store_index"
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  resources :orders
  resources :line_items
  resources :carts
  resources :products do
    get :who_bought, on: :member
  end
  # get "products/:id/who_bought" => "products#who_bought", as: "who_bought"
  get 'up' => 'rails/health#show', as: :rails_health_check
end
