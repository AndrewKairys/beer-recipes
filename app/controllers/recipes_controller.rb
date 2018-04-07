class RecipesController < ApplicationController

  def index
    @recipes = current_user.recipes

    @user = current_user
    @recipe = Recipe.new
  end

  def all_recipes
    @recipes = Recipe.all
  end

  def smash_beers
    @smash_beers = Recipe.smash_beers
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new

    @hops = Hop.all
    @yeasts = Yeast.all
    @fermentables = Fermentable.all
    @styles = Style.all

    @recipe.fermentables.build
    @recipe.hops.build
    @recipe.yeasts.build
    @recipe.recipe_fermentables.build
  end
  #must change setting user and efficiency
  def create
    @recipe = Recipe.new(recipe_params)
    current_user.efficiency = params[:recipe][:user][:efficiency]
    current_user.save
    @recipe.user = current_user

    if @recipe.save
      redirect_to user_recipe_path(current_user, @recipe)
    else
      render :new
    end

  end

  def edit
    # binding.pry
    @recipe = Recipe.find(params[:id])

    @hops = Hop.all
    @yeasts = Yeast.all
    @fermentables = Fermentable.all
    @styles = Style.all
    @recipe_fermentables = @recipe.recipe_fermentables

    @recipe.fermentables.build
    @recipe.hops.build
    @recipe.yeasts.build
  end

  def update
    @recipe = Recipe.find(params[:id])
    current_user.efficiency = params[:recipe][:user][:efficiency]
    current_user.save

    if @recipe.update(recipe_params)
      redirect_to user_recipe_path(@recipe)
    else
      render 'recipes/edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.recipe_fermentables.destroy_all
    @recipe.recipe_hops.destroy_all
    @recipe.recipe_yeasts.destroy_all
    if @recipe.destroy
      flash[:notice] = "Recipe destroyed successfully"
    else
      flash[:notice] = "Recipe could not be destroyed"
    end

    @recipes = current_user.recipes

    render :index
  end



  private

    def recipe_params
      params.require(:recipe).permit(:name,
                                     :boil_time,
                                     :user_id,
                                     :style_id,
                                     # :recipe_fermentables_attributes => [:amount, :fermentable_id],
                                     :fermentable_ids => [],
                                     :fermentables_attributes => [:name, :pound_per_gallon, :lovibond, :diastatic_power],
                                     :hop_ids => [],
                                     :hops_attributes => [:name, :alpha_acids],
                                     :yeast_ids => [],
                                     :yeasts_attributes => [:brand, :variety]
                                   )
    end

end
