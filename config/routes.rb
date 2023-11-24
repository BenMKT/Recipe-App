Rails.application.routes.draw do
  # get 'public_recipes/index'
  devise_for :users

  devise_scope :user do
    get "/custom_sign_out" => "devise/sessions#destroy", as: :custom_destroy_user_session
  end

  resources :public_recipes, only: [:index]

  resources :recipes, only: [:index, :new, :create, :destroy, :show] do
    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
    get 'public_recipes_list', on: :collection
    get 'recipe_details/:id', to: 'recipes#recipe_details', on: :member, as: :recipe_details
    post 'toggle_public/:id', to: 'recipes#toggle_public', on: :member, as: :toggle_public
  end
  
  resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
  
  
  root to: 'foods#index'
  resources :foods, only: [:index, :new, :create, :destroy]
  get '/general_shopping_list', to: 'foods#general_shopping_list', as: 'general_shopping_list'
end
