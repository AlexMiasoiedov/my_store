//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function(){

  $(".deleteItem").on("click", function(event){
    event.preventDefault();
    var current_item_tr = $(this).parents('tr')[0];
    if(confirm("Are you sure?")) {
      $.ajax({
        url: "/items/" + $(current_item_tr).attr('data-item_id'),
        type: "POST",
        data: { _method: "DELETE" },
        success: function(response) {
          $(current_item_tr).fadeOut(200);
          console.log(response);
        }
      });
    };
  });

})