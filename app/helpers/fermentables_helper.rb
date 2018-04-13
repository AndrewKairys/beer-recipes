module FermentablesHelper
  def recipe_fermentable_amount(object)
    if recipe_fermentable = @recipe.recipe_fermentables.find { |rf| rf.fermentable_id == object.id }
      recipe_fermentable.amount
    end
  end
end
