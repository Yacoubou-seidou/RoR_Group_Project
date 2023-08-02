Rails.application.routes.draw do
  # Define your Devise routes for users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }
  get '/public_recipes', to: 'recipes#public_recipes'
  # Define the root path route ("/")
  root 'foods#index'

  # Define resources for Foods, except for 'update'
  resources :foods, except: [:update]

  # Define nested resources for Users and Recipes
  resources :users do
    resources :recipes do
      patch :toggle_public, on: :member
      resources :recipe_foods, only: [:new, :create]
    end
  end

  # Define nested resources for Recipes and RecipeFoods
  resources :recipes, only: [:show] do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
end
