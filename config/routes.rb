Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root "recipes#index"
  
  resources :fermentables, :hops, :recipes, :recipe_fermentables, :recipe_hops, :recipe_yeasts, :yeasts

  resources :users, :only => [:show]

  # Try to delete this permanently
  # get '/auth/facebook/callback' => 'sessions#create'
end
