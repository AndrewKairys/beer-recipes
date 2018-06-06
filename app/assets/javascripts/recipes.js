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
//Must use commented out code below
$(function() {
  $("#new_comment").on("submit", function(e) {
    const data = {
      'authenticity_token': $("input[name='authenticity_token']").val(),
      'comment': {
        'body': $("#comment_body").val()
      }
    }

    $.ajax({
      type: ($("input[name='_method']").val() || this.method),
      url: this.action,
      data: $(this).serialize(),
      success: function(response){
        $("#comment_body").val("")
        const $ol = $("div.comments ol")
        $ol.append(response)
      }
    })

    e.preventDefault()
  })
})



    // function Comment(body, user) {
    //   this.body = body
    //   this.user = user
    // }
    //
    // const comment = new Comment(data.comments.slice(-1)[0].body, data.comments.slice(-1)[0].user.name)
    //
    // Comment.prototype.post = function() {
    //   return this.body + " - Posted by: " + this.user;
    // };
    //
    // $("#comments").append(`<li>${comment.post()}</li>`)
    // $(".comment-body-input").val("")
