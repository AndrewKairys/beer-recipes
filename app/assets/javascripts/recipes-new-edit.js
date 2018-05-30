$(".recipes.new").ready(function() {
  $(function() {
    $("#add-fermentable-button").click(function() {
      let fermentableCounter = parseInt($(".recipe_fermentable_ids").last().attr("data_value")) + 1

      $("#fermentables-selection").append(`<div class="fermentables-dropdown"><select name="recipe[fermentable_ids][]" class="col-md-6 recipe_fermentable_ids" data_value="${fermentableCounter}" onchange="updateFermentableIndexes(this.value, ${fermentableCounter}, '')"><option value=""></option><% fermentables.sort_by { |f| f.name.downcase }.each do |fermentable| %><option value='<%=fermentable.id%>'><%= fermentable.name %></option><% end %></select></div><div class="col-md-6"><div class="col-md-6 input-label"><label>Amount:</label></div><div class="col-md-6 fermentable-amount-input-div-${fermentableCounter}"><input type="number" name="" value="" class="fermentable-amount-input"> (lbs)</div></div><br>`)
    })

    $("#add-hop-button").click(function() {
      let hopCounter = parseInt($(".recipe_hop_ids").last().attr("data_value")) + 1

      $("#hops-selection").append(`<div class="hops-dropdown"><select name="recipe[hop_ids][]" class="col-md-4 recipe_hop_ids" data_value="${hopCounter}" onchange="updateHopIndexes(this.value, ${hopCounter}, '', '')"><option value=""></option><% hops.sort_by { |h| h.name.downcase }.each do |hop| %><option value='<%=hop.id%>'><%= hop.name %></option><% end %></select></div><div class="col-md-4"><div class="col-md-6 input-label"><label>Amount:</label></div><div class="col-md-6 hop-amount-input-div-${hopCounter}"><input type="number" name="" value="" class="hop-amount-input"> (oz)</div></div><div class="col-md-4"><div class="col-md-6 input-label"><label>Addition Time:</label></div><div class="col-md-6 hop-addition-time-input-div-${hopCounter}"><input type="number" name="" value="" class="hop-amount-input"> (min)<br></div></div>`)
    })
  })

  function updateFermentableIndexes(id, index, amount) {
    if(id === "") {
      $(`.fermentable-amount-input-div-${index}`).html(`<input type="number" name="" value="" class="fermentable-amount-input"> (lbs)`)
    } else {
      $(`.fermentable-amount-input-div-${index}`).html(`<input type="number" name="recipe[recipe_fermentable_attributes][${id}][amount]" value="${amount}" class="fermentable-amount-input"> (lbs)`)
    }
  }

  function updateHopIndexes(id, index, amount, addition_time) {
    if(id === "") {
      $(`.hop-amount-input-div-${index}`).html(`<input type="number" name="" value="" class="hop-amount-input"> (oz)`)
      $(`.hop-addition-time-input-div-${index}`).html(`<input type="number" name="" value="" class="hop-amount-input"> (min)<br>`)
    } else {
      $(`.hop-amount-input-div-${index}`).html(`<input type="number" name="recipe[recipe_hop_attributes][${id}][amount]" value="${amount}" class="hop-amount-input"> (oz)`)
      $(`.hop-addition-time-input-div-${index}`).html(`<input type="number" name="recipe[recipe_hop_attributes][${id}][addition_time]" value="${addition_time}" class="hop-amount-input"> (min)<br>`)
    }
  }

  $("#add-yeast-button").click(function() {
    $("#yeast-selection").append("<select name='recipe[yeast_ids][]' id='recipe_yeast_ids'><option value=''></option><% yeasts.order(:brand, :variety).each do |yeast| %><option value='<%=yeast.id%>'><%= yeast.brand %> - <%=yeast.variety%></option><% end %></select><br>")
  })
})
