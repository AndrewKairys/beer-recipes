class CommentsController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(body: params[:comment][:body], user_id: current_user.id)
    @comment.save
  end

end
