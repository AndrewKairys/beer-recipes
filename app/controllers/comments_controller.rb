class CommentsController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(body: params[:comment][:body], user_id: current_user.id)

    if @comment.save
      redirect_to @recipe
    else
      render 'recipes/show'
    end
  end

  # private
  #   def comments_params
  #     params.require(:comment).permit(:body)
  #   end

end
