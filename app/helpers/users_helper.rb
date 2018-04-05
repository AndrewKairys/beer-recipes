module UsersHelper
  def no_recipes?
    if @recipes.empty?
      flash[:alert] = "Create your first recipe with the button above!"
    end
  end
end
