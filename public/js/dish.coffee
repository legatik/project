$(document).ready () ->
  console.log "dish page"
  user = JSON.parse $("#hide-input").attr("dataUser")
  dish = JSON.parse $("#hide-input").attr("dataDish")
  $("#hide-input").remove()
  console.log "use", user
  console.log "dish", dish

