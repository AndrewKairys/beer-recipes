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

  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    binding.pry

    @hops = Hop.all
    @yeasts = Yeast.all
    @fermentables = Fermentable.all
    @styles = Style.all

    if @recipe.save
      binding.pry
      @recipe.add_fermentable_amounts(params[:recipe][:fermentable_amounts])
      @recipe.add_hop_amounts(params[:recipe][:hop_amounts])
      @recipe.add_addition_time(params[:recipe][:addition_time])

      redirect_to user_recipe_path(current_user, @recipe)
    else
      render :new
    end

  end

  def edit
    @recipe = Recipe.find(params[:id])

    @hops = Hop.all
    @yeasts = Yeast.all
    @fermentables = Fermentable.all
    @styles = Style.all

    # @recipe.fermentables.build
    @recipe.hops.build
    @recipe.yeasts.build
  end

  def update
    binding.pry
    @recipe = Recipe.find(params[:id])

    @hops = Hop.all
    @yeasts = Yeast.all
    @fermentables = Fermentable.all
    @styles = Style.all

    if @recipe.update(recipe_params)
      #***Start building these methods below***
      # @recipe.update_fermentable_amounts(params[:recipe][:fermentable_amounts])
      # @recipe.update_hop_amounts(params[:recipe][:hop_amounts])
      # @recipe.update_addition_time(params[:recipe][:addition_time])

      redirect_to user_recipe_path(@recipe)
    else
      render :edit
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
                                     :style_id,
                                     :efficiency,
                                     :fermentables_attributes => [:name, :pound_per_gallon, :lovibond, :diastatic_power],
                                     :hops_attributes => [:name, :alpha_acids],
                                     :yeast_ids => [],
                                     :yeasts_attributes => [:brand, :variety]
                                   )
    end
end
