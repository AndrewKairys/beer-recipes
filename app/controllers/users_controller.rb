class UsersController < ApplicationController
  def show
    @user = current_user
    @recipes = Recipe.where("user_id = ?", current_user)
    helpers.no_recipes?
  end
end
