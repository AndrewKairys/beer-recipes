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

1. [] Create form for making a new recipe
     [X]-Creates a new recipe
        -Auto user_id ***Manually sets it in conrtoller right now***
     [X]-Route:
        -Get '/recipes/new' new_recipe_path
        -Post '/recipes'
     [X]-Has form for fermentables, hops, and yeasts
        -First or Create new fermentables, hops, and yeasts
        -Drop down with options would be nice ***Will have to wait for JS to make this exactly how I want***
        -Automatically creates and assigns ingredients as recipe_fermentables, recipe_hops, recipe_yeasts.
     [X]-Has submit button
2. [X] Edit page for recipe
3. [X] Validations
      [X] -Need to display errors
4. [X] User Show page with all their recipes
5. [X] OmniAuth
6. [X] Destroy method
      [X] -If a recipe is destroyed, all recipe ingredients must go as well.
7. [] Authorization
8. [] Use partials for recipe edit and new page
9. [X] Change ingredient attributes to join table
        -Fermentables - amount
        -Hops addition_time, amount
10. [] CSS styling of all error messaages
        -Currently only recipe name has css (automatic div tag only created on name)
11. [X] Add style model
        -Give style attribute to recipe
          -Add this to new and edit forms
12. [] Get rid of inline css
13. [] Bootstrap the styling
14. [] Change efficiency attribute back to recipe

Last. [] Refactor
          -Before action in controllers. Set up find method.


          <%= form_for [current_user, @recipe] do |f| %>

            <% if @recipe.errors.any? %>
              <div id="error_explanation">
                <h2>
                  <%= pluralize(@recipe.errors.count, "error") %>
                  prohibited this post from being saved:
                </h2>

                <ul>
                <% @recipe.errors.full_messages.each do |msg| %>
                  <li><%= msg %></li>
                <% end %>
                </ul>
              </div>
            <% end %>

            <%= f.label "Name:" %>
            <%= f.text_field :name %><br>
            <%= f.label "Boil Time (min):" %>
            <%= f.number_field :boil_time %><br></br>

            <%= f.label "Style:" %>
            <%= f.collection_select(:style_id, @styles.sort_by { |f| f.name }, :id, :name, include_blank: true) %><br>

            <%= f.fields_for current_user do |ff|%>
              <%= ff.label "Brewhouse Efficiency Percentage:" %>
              <%= ff.number_field :efficiency %><br>
            <% end %>

            <section>
              <h3>Fermentables</h3>

              <%= f.collection_check_boxes(:fermentable_ids, @fermentables, :id, :name) do |b| %>
                <div class="row">
                  <%= b.label(class: "check_box") do %>
                    <div class="col-xs-4">
                      <%= b.check_box(class: "check_box") %>
                      <%= b.object.name %>
                    </div>
                  <% end %>
                </div>
              <% end %><br>

              <h4>Add a new fermentable to your recipe</h4>
              <label>Name:</label>
              <input type="text" name="recipe[fermentables_attributes][][name]">
              <label>PPG:</label>
              <input type="text" name="recipe[fermentables_attributes][][pound_per_gallon]">
              <label>Lovibond:</label>
              <input type="text" name="recipe[fermentables_attributes][][lovibond]">
              <label>DP:</label>
              <input type="text" name="recipe[fermentables_attributes][][diastatic_power]" >

            </section>

            <section>
              <h3>Hops</h3>

              <%= f.collection_check_boxes(:hop_ids, @hops, :id, :name) do |b| %>
                <div class="row">
                  <%= b.label(class: "check_box") do %>
                    <div class="col-xs-4">
                      <%= b.check_box(class: "check_box") %>
                      <%= b.object.name %>
                    </div>
                  <% end %>
                </div>
              <% end %><br>

              <h4>Add a new hop variety to your recipe</h4>
              <label>Name:</label>
              <input type="text" name="recipe[hops_attributes][][name]">
              <label>AA:</label>
              <input type="text" name="recipe[hops_attributes][][alpha_acids]">

            </section>

            <section>
              <h3>Yeasts</h3>

              <%= f.collection_check_boxes(:yeast_ids, @yeasts, :id, :variety) do |b| %>
                <div class="row">
                  <%= b.label(class: "check_box") do %>
                    <div class="col-xs-4">
                      <%= b.check_box(class: "check_box") %>
                      <%= b.object.brand %> |
                      <%= b.object.variety %>
                    </div>
                  <% end %>
                </div>
              <% end %><br>

              <h4>Add new yeast to your recipe</h4>
              <label>Brand:</label>
              <input type="text" name="recipe[yeasts_attributes][][brand]" >
              <label>Variety:</label>
              <input type="text" name="recipe[yeasts_attributes][][variety]" >

            </section>

            <br></br>
            <%= f.submit %>
          <% end %>
