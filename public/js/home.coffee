$(document).ready () ->
  $('.carousel').find(".item").first().addClass("active")
  $('.carousel-indicators').find("li").first().addClass("active")
  $('.carousel').carousel()
#  $.ajax
#    url: "/home/popular_dish"
#    success: (data) =>
#      console.log "data",data.result
#      console.log "data",data[0]
#      console.log "data",data[1]

