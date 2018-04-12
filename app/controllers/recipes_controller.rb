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

    @hops = Hop.all
    @yeasts = Yeast.all
    @fermentables = Fermentable.all
    @styles = Style.all

    if @recipe.save
      @recipe.add_recipe_fermentable_amount(params[:recipe][:new_fermentable].first[:amount])
      @recipe.add_recipe_hop_amount(params[:recipe][:new_hop].first[:amount])
      @recipe.add_recipe_hop_addition_time(params[:recipe][:new_hop].first[:addition_time])

      @recipe.add_recipe_fermentables(params[:recipe][:fermentable_amounts], params[:recipe][:fermentable_ids])
      @recipe.add_recipe_hops(params[:recipe][:hop_amounts], params[:recipe][:hop_ids])
      @recipe.add_addition_time(params[:recipe][:addition_time], params[:recipe][:hop_ids])

      redirect_to user_recipe_path(current_user, @recipe)
    else
      @recipe.fermentables.build
      @recipe.hops.build
      @recipe.yeasts.build

      render :new
    end

  end

  def edit
    @recipe = Recipe.find(params[:id])

    @styles = Style.all
    @yeasts = Yeast.all
    @hops = Hop.all
    @fermentables = Fermentable.all

    @recipe.fermentables.build
    @recipe.hops.build
    @recipe.yeasts.build
  end

  def update
    @recipe = Recipe.find(params[:id])

    @styles = Style.all
    @yeasts = Yeast.all
    @fermentables = Fermentable.all
    @hops = Hop.all

    if @recipe.update(recipe_params)
      @recipe.update_hops(params[:recipe][:hop_amounts], params[:recipe][:addition_time], params[:recipe][:hop_ids], params[:recipe][:new_hop].first[:amount])
      @recipe.update_fermentables(params[:recipe][:fermentable_amounts], params[:recipe][:fermentable_ids], params[:recipe][:new_fermentable].first[:amount])

      @recipe.add_recipe_fermentable_amount(params[:recipe][:new_fermentable].first[:amount])
      @recipe.add_recipe_hop_amount(params[:recipe][:new_hop].first[:amount])
      @recipe.add_recipe_hop_addition_time(params[:recipe][:new_hop].first[:addition_time])

      redirect_to user_recipe_path(@recipe)
    else
      @recipe.fermentables.build
      @recipe.hops.build
      @recipe.yeasts.build

      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])

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
