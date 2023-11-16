Rails.application.routes.draw do
  get 'public_recipes/index'
  get 'recipe_steps/new'
  get 'recipe_steps/create'
  devise_for :users

  devise_scope :user do
    get "/custom_sign_out" => "devise/sessions#destroy", as: :custom_destroy_user_session
  end

  resources :public_recipes, only: [:index]

  resources :users, only: [] do
    resources :recipes, only: [:index]
  end

  resources :recipes, except: [:update] do
    member do
      patch 'toggle_public'
      patch 'update_times'
      get 'new_step', to: 'recipe_steps#new'
      post 'create_step', to: 'recipe_steps#create'
    end

    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
  end

  root to: 'foods#index'
  resources :foods, only: [:index, :new, :create, :destroy]
  get '/general_shopping_list', to: 'foods#general_shopping_list', as: 'general_shopping_list'
end
