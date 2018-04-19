class UsersController < ApplicationController
  def show
    @user = current_user
    @recipes = Recipe.where("user_id = ?", @user)
    helpers.no_recipes?
  end

end
