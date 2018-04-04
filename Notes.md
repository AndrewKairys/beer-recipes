Models
  -User (Devise)
    -(devise methods)
    -has_many :recipes
  -Recipe
    -belongs_to :user
    -has_many :recipe_ingredients
    -has_many :hops, through: :recipe_ingredients
    -has_many :fermentables, through: :recipe_ingredients
    -has_many :yeasts, through: :recipe_ingredients
  -Hop
    -has_many :recipe_ingredients
    -has_many :recipes, through: recipe_ingredients
  -Fermentable
    -has_many :recipe_ingredients
    -has_many :recipes, through: recipe_ingredients
  -Yeast
    -has_many :recipe_ingredients
    -has_many :recipes, through: recipe_ingredients
  -Recipe_Ingredients (Join Table)
    -belongs_to :recipe
    -belongs_to :hop
    -belongs_to :fermentable
    -belongs_to :yeast

Migrations
  -User (Devise)
    -name
    -email
    -password
    -(possibly other devise attributes)
  -Recipe
    -name
    -boil_time
    -efficiency
  -Hop
    -name
    -amount
    -AA
    -time
  -Fermentable
    -name
    -amount
    -ppg
    -lovibond
    -dp
  -Yeast
    -brand
    -variety
  -Recipe_Ingredients (Join Table)
    -recipe_id
    -hop_id
    -fermentable_id
    -yeast_id

1. Create form for making a new recipe
    -Creates a new recipe
      -Auto user_id
    -Route:
      -Get '/recipes/new' new_recipe_path
      -Post '/recipes'
    -Has form for fermentables, hops, and yeasts
      -First or Create new fermentables, hops, and yeasts
      -Drop down with options would be nice
      -Automatically creates and assigns ingredients as recipe_fermentables, recipe_hops, recipe_yeasts.
    -Has submit button

1. (a) Edit page for recipe

2. Validations

3. User Show page with all their recipes

4. OmniAuth
