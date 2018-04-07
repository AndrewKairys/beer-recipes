Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root "users#show"

  get '/recipes/smash_beers' => 'recipes#smash_beers'
  get '/all_recipes' => 'recipes#all_recipes', as: 'all_recipes'
  get '/styles/most_popular' => 'styles#most_popular'

  resources :fermentables, :hops, :recipe_fermentables, :recipe_hops, :recipe_yeasts, :yeasts
  resources :users, only: [:show] do
    resources :recipes, only: [:show, :index, :edit, :new, :destroy, :create, :update]
  end


end
