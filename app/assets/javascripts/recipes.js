$(function () {

  $(".js-next").on("click", function() {
    const userId = parseInt($(".js-next").attr("data-user-id"))
    // This is not a good way to do things because recipe ids don't always increment by 1. (ex. recipes can get deleted)
    const nextId = parseInt($(".js-next").attr("data-id")) + 1;

    $.get("/users/" + userId + "/recipes/" + nextId + ".json", function(data) {
      $(".recipeName").text(data.name);
      $(".userName").text(data.user.name);
      $(".styleName").text(data.style.name);

      const recipeFermentables = data.recipe_fermentables
      const fermentables = data.fermentables
      $(".fermentables").html("")
      for (var i = 0, l = recipeFermentables.length; i < l; ++i) {
        $(".fermentables").append("<li>" + fermentables[i].name + " | " + recipeFermentables[i].amount + " lbs | </li>");
      }

      const recipeHops = data.recipe_hops
      const hops = data.hops
      $(".hops").html("")
      for (var i = 0, l = recipeHops.length; i < l; ++i) {
        $(".hops").append("<li>" + hops[i].name + " | " + recipeHops[i].amount + " oz | " + recipeHops[i].addition_time + " min</li>");
      }

      const yeasts = data.yeasts
      $(".yeasts").html("")
      for (var i = 0, l = yeasts.length; i < l; ++i) {
        $(".yeasts").append("<li>" + yeasts[i].brand + "</li>" +
                          "<ul>" +
                            "<li>" + yeasts[i].variety + "</li>" +
                          "</ul>");
      }

      $(".js-next").attr("data-id", data["id"]);
      $("#edit-link").attr("href", `/users/${userId}/recipes/${data.id}/edit`);
      $("#delete-link").attr("href", `/users/${userId}/recipes/${data.id}`);
    });
  });
});
