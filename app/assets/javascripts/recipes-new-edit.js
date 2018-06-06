$(".recipes.new, .recipes.edit").ready(function() {
//CUSTOM SORT FUNCTION
  const sort_by = function() {
    const fields = [].slice.call(arguments)

    return function(A, B) {
      let a, b, field, result;
      for (let i = 0, l = fields.length; i < l; i++) {
        result = 0;
        field = fields[i];

        a = A[field].toLowerCase();
        b = B[field].toLowerCase();

        if (a < b) result = -1;
        if (a > b) result = 1;
        if (result !== 0) break;
      }
      return result;
    }
  }

//HANDLEBARS HELPERS
  Handlebars.registerHelper('fermentableCounter', function() {
    return parseInt($(".recipe_fermentable_ids").last().attr("data_value")) + 1
  })

  Handlebars.registerHelper('hopCounter', function() {
    return parseInt($(".recipe_hop_ids").last().attr("data_value")) + 1
  })

//ONCLICK FUNCTIONS
  $("#add-fermentable-button").click(function() {
    fetch("/fermentables.json", { credentials: 'include' })
    .then(res => res.json())
    .then(fermentables => {
      const templateScript = $("#fermentable-dropdown-template").html();
      const template = Handlebars.compile(templateScript);
      sortFermentables(fermentables)
      const result = template(fermentables);

      $("#fermentable-selection").append(result)
    })
  })

  $("#add-hop-button").click(function() {
    fetch("/hops.json", { credentials: 'include' })
    .then(res => res.json())
    .then(hops => {
      const templateScript = $("#hop-dropdown-template").html();
      const template = Handlebars.compile(templateScript);
      sortHops(hops)
      const result = template(hops);

      $("#hop-selection").append(result)
    })
  })

  $("#add-yeast-button").click(function() {
    fetch("/yeasts.json", { credentials: 'include' })
    .then(res => res.json())
    .then(yeasts => {
      const templateScript = $("#yeast-dropdown-template").html();
      const template = Handlebars.compile(templateScript);
      sortYeasts(yeasts)
      const result = template(yeasts);

      $("#yeast-selection").append(result)
    })
  })

//SORT FUNCTIONS FOR EACH INGREDIENT CATEGORY
//Could be more DRY by using sortIngredients once for hops and fermentables but that make it confusing since yeasts are sorted differently
  function sortFermentables(fermentables) {
    fermentables.sort(sort_by('name'))
  }

  function sortHops(hops) {
    hops.sort(sort_by('name'))
  }

  function sortYeasts(yeasts) {
    yeasts.sort(sort_by('brand', 'variety'))
  }
})
