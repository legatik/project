$(document).ready () ->
  
  $('.carousel').find(".item").first().addClass("active")
  $('.carousel-indicators').find("li").first().addClass("active")
  $('.carousel').carousel()
  $.ajax
    url: "/date_dish"
    success: (data) =>
      data.forEach (model) ->
        dishBookView = new window.DishView({model:model})
        $("#dish-date-cont").append(dishBookView.render().el)

