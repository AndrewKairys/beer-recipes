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
6.  [X] Move JS in form partial to its own js file and render with dynamically generated classes.
7.  [X] Add Handlebars and use that with js files.
8.  [] Make sure you use ES6 features as much as possible (e.g. Arrow functions, Let & Const, Class, constructor functions)
9.  [X] Work on styling
10. [X] Make sure everything is as dry as possible.
11. [X] Get rid of remote true? (show.html.erb, line 41) This is the dumbest shit ever!!!


Wants but not necessary
1.  [] Clicking next and previous for your recipes works beautifully. Clicking next for all recipes does not work. I need two seperate JS functions and/or show pages when displaying all vs. your recipes. Currently just goes through current users recipes.
2.  [] Don't display next button on last recipe/Don't display previous button on first recipe. Delete current error messages.
3.  [] Fix the feature of not being able to enter decimal amounts for fermentables (maybe hops too)
4.  [] Render new ingredients and style field with JS.
5.  [] Add loading icon/don't display next/previous buttons until fetch request is finished.
6.  [] Make less requests using active_model_seializers.
7.  [] Organize recipes.scss for better readability/put css in separate file when appropriate.
