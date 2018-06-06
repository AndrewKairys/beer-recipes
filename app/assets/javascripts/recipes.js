// HANLDEBARS!?!?!
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
