function loadUserRecipes (){
  $(".recipes.index").ready(function() {
    const userId = parseInt($("h1").attr("data-user-id"))

    fetch(`/users/${userId}/recipes.json`, { credentials: 'include' })
      .then(res => res.json())
      .then(json => {
        for (let i = 0, l = json.length; i < l; ++i) {
          $(".recipes-list").append("<li>" + "<a href='/users/" + json[i].user.id + "/recipes/" + json[i].id + "'>" + json[i].name + "</a>" + "</li>");
        }
      })

  })
}

loadUserRecipes()
