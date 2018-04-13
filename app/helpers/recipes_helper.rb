module RecipesHelper
  def edit_button_if_current_user
    if @recipe.user == current_user
      link_to("Edit Recipe", edit_user_recipe_path(current_user, @recipe)).html_safe
    end
  end

  def delete_button_if_current_user
    if @recipe.user == current_user
      link_to("Delete Recipe", user_recipe_path(@recipe), :method => :delete).html_safe
    end
  end

  def add_recipe_ingredients
    @recipe.add_recipe_fermentable_amount(params[:recipe][:new_fermentable].first[:amount])
    @recipe.add_recipe_hop_amount(params[:recipe][:new_hop].first[:amount])
    @recipe.add_recipe_hop_addition_time(params[:recipe][:new_hop].first[:addition_time])

    @recipe.add_recipe_fermentables(params[:recipe][:fermentable_amounts], params[:recipe][:fermentable_ids])
    @recipe.add_recipe_hops(params[:recipe][:hop_amounts], params[:recipe][:hop_ids])
    @recipe.add_addition_time(params[:recipe][:addition_time], params[:recipe][:hop_ids])
  end

  def update_recipe_ingredients
    @recipe.add_recipe_fermentable_amount(params[:recipe][:new_fermentable].first[:amount])
    @recipe.add_recipe_hop_amount(params[:recipe][:new_hop].first[:amount])
    @recipe.add_recipe_hop_addition_time(params[:recipe][:new_hop].first[:addition_time])

    @recipe.update_hops(params[:recipe][:hop_amounts], params[:recipe][:addition_time], params[:recipe][:hop_ids], params[:recipe][:new_hop].first[:amount])
    @recipe.update_fermentables(params[:recipe][:fermentable_amounts], params[:recipe][:fermentable_ids], params[:recipe][:new_fermentable].first[:amount])
  end

end
