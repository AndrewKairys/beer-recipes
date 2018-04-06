Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root "recipes#index"

  get '/recipes/smash_beers' => 'recipes#smash_beers'

  resources :fermentables, :hops, :recipes, :recipe_fermentables, :recipe_hops, :recipe_yeasts, :yeasts

  resources :users, :only => [:show]
  #Make routes for SMASH beers and most_popular style
  #URL: /style/most_popular
  #URL: /recipes/smash
  get '/styles/most_popular' => 'styles#most_popular'

end
