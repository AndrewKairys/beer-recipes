class RecipesController < ApplicationController
  before_action :load_recipe, :only => [:show, :edit, :update, :destroy]
  before_action :load_ingredients_and_styles, :only => [:new, :create, :edit, :update]

  def index
    @recipes = current_user.recipes
    helpers.no_recipes?
  end

  def all_recipes
    @recipes = Recipe.all
  end

  def smash_beers
    @smash_beers = Recipe.smash_beers
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @recipe }
    end
  end

  def new
    @recipe = Recipe.new

    build_ingredients
    @recipe.build_style
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    @recipe.add_new_style(params[:recipe][:style][:name])

    if @recipe.save
      helpers.add_recipe_ingredients

      redirect_to user_recipe_path(current_user, @recipe)
    else
      build_ingredients

      render :new
    end

  end

  def edit
    recipe = Recipe.find(params[:id])

    if recipe.user == current_user
      build_ingredients
    else
      redirect_to user_path, :alert => "That is not your recipe"
    end
  end

  def update
    if @recipe.update(recipe_params)
      helpers.update_recipe_ingredients

      redirect_to user_recipe_path(@recipe)
    else
      build_ingredients

      render :edit
    end
  end

  def destroy
    if @recipe.destroy
      flash[:notice] = "Recipe destroyed successfully"
    else
      flash[:notice] = "Recipe could not be destroyed"
    end

    redirect_to user_recipes_path
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

    def load_recipe
      @recipe ||= Recipe.find(params[:id])
    end

    def load_ingredients_and_styles
      @styles ||= Style.all
      @fermentables ||= Fermentable.all
      @hops ||= Hop.all
      @yeasts ||= Yeast.all
    end

    def build_ingredients
      @recipe.fermentables.build
      @recipe.hops.build
      @recipe.yeasts.build
    end
end
