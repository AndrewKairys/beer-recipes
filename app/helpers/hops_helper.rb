module HopsHelper
  def recipe_hop_amount(object)
    if recipe_hop = @recipe.recipe_hops.find { |rf| rf.hop_id == object.id }
      recipe_hop.amount
    end
  end

  def recipe_hop_addition_time(object)
    if recipe_hop = @recipe.recipe_hops.find { |rf| rf.hop_id == object.id }
      recipe_hop.addition_time
    end
  end

end
