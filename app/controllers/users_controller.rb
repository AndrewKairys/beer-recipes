class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = Recipe.where("user_id = ?", params[:id])
  end
end
