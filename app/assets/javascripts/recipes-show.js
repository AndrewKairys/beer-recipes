function loadRecipe() {
  $(".recipes.show").ready(function() {
    const userId = parseInt($(".js-next").attr("data-user-id"))

    fetch(`/users/${userId}/recipes.json`, { credentials: 'include' })
    .then(res => res.json())
    .then(json => {
      $(".change-recipe-button").on("click", function() {
        let recipeId = parseInt($(".js-next").attr("data-id"));
        let recipeIndex = json.findIndex(recipe => recipe.id === recipeId);
        let recipe
        let errorMessage

        if(this.classList.value.includes("js-previous")) {
          recipe = json[recipeIndex - 1]
          errorMessage = "Sorry, that is the first recipe"
        } else if(this.classList.value.includes("js-next")) {
          recipe = json[recipeIndex + 1]
          errorMessage = "Sorry, that is the last recipe"
        }

        if(recipe !== undefined){
          $(".recipeName").text(recipe.name);
          $(".userName").text(recipe.user.name);
          $(".styleName").text(recipe.style.name);

          const recipeFermentables = recipe.recipe_fermentables.sort(function(a, b){
             const x = a.fermentable.name.toLowerCase();
             const y = b.fermentable.name.toLowerCase();
             if (x < y) {return -1;}
             if (x > y) {return 1;}
             return 0;
          });

          $(".fermentables").html("")
          for (var i = 0, l = recipeFermentables.length; i < l; ++i) {
            $(".fermentables").append("<li>" + recipeFermentables[i].fermentable.name + " | " + recipeFermentables[i].amount + " lbs </li>");
          }

          const recipeHops = recipe.recipe_hops.sort(function (a, b) { return b.addition_time - a.addition_time});

          $(".hops").html("")
          for (var i = 0, l = recipeHops.length; i < l; ++i) {
            $(".hops").append("<li>" + recipeHops[i].hop.name + " | " + recipeHops[i].amount + " oz | " + recipeHops[i].addition_time + " min</li>");
          }

          const yeasts = recipe.yeasts
          $(".yeasts").html("")
          for (var i = 0, l = yeasts.length; i < l; ++i) {
            $(".yeasts").append("<li>" + yeasts[i].brand + "</li>" + "<ul>" + "<li>" + yeasts[i].variety + "</li>" +"</ul>");
          }

          fetch(`/users/${userId}/recipes/${recipe.id}.json`, { credentials: 'include' })
          .then(res => res.json())
          .then(json => {
            const comments = json.comments
            $("#comments").html("")
            for (var i = 0, l = comments.length; i < l; ++i) {
              $("#comments").append(`<li>${comments[i].body} - Posted by: ${comments[i].user.name}</li>`);
            }
          })

          $("#change-recipe-button-error").html("");
          $(".js-next").attr("data-id", recipe["id"]);
          $("#edit-link").attr("href", `/users/${userId}/recipes/${recipe.id}/edit`);
          $("#delete-link").attr("href", `/users/${userId}/recipes/${recipe.id}`);
          window.history.replaceState(null, null, `/users/${userId}/recipes/${recipe.id}`);
          $("#new_comment").attr("action", `/recipes/${recipe.id}/comments`)
        } else {
          $("#change-recipe-button-error").html(errorMessage);
        }
      })
    })
  })
}


$(function() {
  $("#new_comment").on("submit", function(e) {

    $.ajax({
      type: ($("input[name='_method']").val() || this.method),
      url: this.action,
      data: $(this).serialize()
    }).success(function() {
      const userId = parseInt($(".js-next").attr("data-user-id"))
      const recipeId = parseInt($(".js-next").attr("data-id"));

      $.get(`/users/${userId}/recipes/${recipeId}.json`, function(data) {
        if($(".comment-body-input").val() !== "") {
          function Comment(body, user) {
            this.body = body
            this.user = user
          }

          const comment = new Comment(data.comments.slice(-1)[0].body, data.comments.slice(-1)[0].user.name)

          Comment.prototype.post = function() {
            return this.body + " - Posted by: " + this.user;
          };

          $(".comment-body-input").val("")
          $("#comments").append(`<li>${comment.post()}</li>`)
        } else {
          alert("Please type a comment with some content.")
        }
      })
    })

    e.preventDefault()
  })
})

loadRecipe()
