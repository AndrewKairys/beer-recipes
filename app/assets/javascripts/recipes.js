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
