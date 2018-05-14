1. [X] Create form for making a new recipe
     [X]-Creates a new recipe
        -Auto user_id
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
7. [] Authorization ***Maybe don't do this***
        -Pundit or CanCanCan
8. [X] Use partials for recipe edit and new page
9. [X] Change ingredient attributes to join table
        -Fermentables - amount
        -Hops addition_time, amount
10. [X] CSS styling of all error messaages
        -Currently only recipe name has css (automatic div tag only created on name)
11. [X] Add style model
        -Give style attribute to recipe
          -Add this to new and edit forms
12. [X] Get rid of inline css
13. [X] Bootstrap the styling
14. [X] Change efficiency attribute back to recipe
15. [X] Complete Readme
16. [] Style error messages

Last. [X] Refactor
          -Before action in controllers. Set up find method.

Javascript Notes
Add Jquery
Add AMS
Make user recipe index have json backend and render via ajax get request
Add next and previous button to recipe show page and have json backend and render via ajax get request
Render recipe ingredients on show page with json backend and render via ajax get request
