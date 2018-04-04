Rails.application.routes.draw do
  devise_for :users

  root to: "recipes#index"

  resources :fermentables, :hops, :recipes, :recipe_fermentables, :recipe_hops, :recipe_yeasts, :yeasts

  resources :users, :only => [:show]

end
