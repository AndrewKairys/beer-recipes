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
1.  [X] Add Jquery
2.  [X] Add AMS
3.  [X] Make user recipe index have json backend and render via ajax get request (Need to put JS not in view and modify serializers to be more dry.)
4.  [X] Add next button to recipe show page
5.  [X] Render recipe ingredients on show page on "next recipe" click with json backend and render via ajax get request (reference notes for making it better)
6.  [] Clicking next and previous for your recipes works beautifully. Clicking next for all recipes does not work. I need two seperate JS functions and/or show pages when displaying all vs. your recipes. Currently just goes through current users recipes.
7.  [] Move JS in form partial to its own js file and render with dynamically generated classes.
8.  [] Add Handlebars and using that with js files.
9.  [] Read notes in show page regarding next and previous buttons.
10. [] Make use of more ES6 features (e.g. Arrow functions, Let & Const, Class, constructor functions)
