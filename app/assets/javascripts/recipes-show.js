// ***DRY THIS OUT***
function loadRecipe() {
  $(".recipes.show").ready(function() {
    const userId = parseInt($(".js-next").attr("data-user-id"))

    fetch(`/users/${userId}/recipes.json`, { credentials: 'include' })
    .then(res => res.json())
    .then(json => {
      $(".js-next").on("click", function() {
        let recipeId = parseInt($(".js-next").attr("data-id"));
        let recipeIndex = json.findIndex(recipe => recipe.id === recipeId);
        let nextRecipe = json[recipeIndex + 1]

        if(recipeIndex !== json.length - 1){
          $(".recipeName").text(nextRecipe.name);
          $(".userName").text(nextRecipe.user.name);
          $(".styleName").text(nextRecipe.style.name);

          const recipeFermentables = nextRecipe.recipe_fermentables.sort(function(a, b){
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

          const recipeHops = nextRecipe.recipe_hops.sort(function (a, b) { return b.addition_time - a.addition_time});

          $(".hops").html("")
          for (var i = 0, l = recipeHops.length; i < l; ++i) {
            $(".hops").append("<li>" + recipeHops[i].hop.name + " | " + recipeHops[i].amount + " oz | " + recipeHops[i].addition_time + " min</li>");
          }

          const yeasts = nextRecipe.yeasts
          $(".yeasts").html("")
          for (var i = 0, l = yeasts.length; i < l; ++i) {
            $(".yeasts").append("<li>" + yeasts[i].brand + "</li>" + "<ul>" + "<li>" + yeasts[i].variety + "</li>" +"</ul>");
          }

          fetch(`/users/${userId}/recipes/${nextRecipe.id}.json`, { credentials: 'include' })
          .then(res => res.json())
          .then(json => {
            const comments = json.comments
            $("#comments").html("")
            for (var i = 0, l = comments.length; i < l; ++i) {
              $("#comments").append(`<li>${comments[i].body} - Posted by: ${comments[i].user.name}</li>`);
            }
          })

          $("#next-button-error").html("");
          $(".js-next").attr("data-id", nextRecipe["id"]);
          $("#edit-link").attr("href", `/users/${userId}/recipes/${nextRecipe.id}/edit`);
          $("#delete-link").attr("href", `/users/${userId}/recipes/${nextRecipe.id}`);
          window.history.replaceState(null, null, `/users/${userId}/recipes/${nextRecipe.id}`);
          $("#new_comment").attr("action", `/recipes/${nextRecipe.id}/comments`)
        } else {
          $("#next-button-error").html("Sorry, that is the last recipe");
        }
      })

      $(".js-previous").on("click", function() {
        let recipeId = parseInt($(".js-next").attr("data-id"));
        let recipeIndex = json.findIndex(recipe => recipe.id === recipeId);
        let previousRecipe = json[recipeIndex - 1]

        if(recipeIndex !== 0){
          $(".recipeName").text(previousRecipe.name);
          $(".userName").text(previousRecipe.user.name);
          $(".styleName").text(previousRecipe.style.name);

          const recipeFermentables = previousRecipe.recipe_fermentables.sort(function(a, b){
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

          const recipeHops = previousRecipe.recipe_hops.sort(function (a, b) { return b.addition_time - a.addition_time});
          $(".hops").html("")
          for (var i = 0, l = recipeHops.length; i < l; ++i) {
            $(".hops").append("<li>" + recipeHops[i].hop.name + " | " + recipeHops[i].amount + " oz | " + recipeHops[i].addition_time + " min</li>");
          }

          const yeasts = previousRecipe.yeasts
          $(".yeasts").html("")
          for (var i = 0, l = yeasts.length; i < l; ++i) {
            $(".yeasts").append("<li>" + yeasts[i].brand + "</li>" + "<ul>" + "<li>" + yeasts[i].variety + "</li>" +"</ul>");
          }

          fetch(`/users/${userId}/recipes/${previousRecipe.id}.json`, { credentials: 'include' })
          .then(res => res.json())
          .then(json => {
            const comments = json.comments
            $("#comments").html("")
            for (var i = 0, l = comments.length; i < l; ++i) {
              $("#comments").append(`<li>${comments[i].body} - Posted by: ${comments[i].user.name}</li>`);
            }
          })

          $("#next-button-error").html("");
          $(".js-next").attr("data-id", previousRecipe["id"]);
          $("#edit-link").attr("href", `/users/${userId}/recipes/${previousRecipe.id}/edit`);
          $("#delete-link").attr("href", `/users/${userId}/recipes/${previousRecipe.id}`);
          window.history.replaceState(null, null, `/users/${userId}/recipes/${previousRecipe.id}`);
          $("#new_comment").attr("action", `/recipes/${previousRecipe.id}/comments`)
        } else {
          $("#next-button-error").html("Sorry, that is the first recipe");
        }
      })
    });
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
