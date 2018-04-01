Rails.application.routes.draw do
  devise_for :users

  root to: "recipes#index"

  resources :fermentables, :hops, :recipes, :recipe_ingredients, :yeasts

end
