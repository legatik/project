$(document).ready () ->

  specObj =
    first_course:
      name : "Первые блюда"
      key : "first_course"
    main_dishes:
      name : "Вторые блюда"
      key : "main_dishes"
    snack:
      name : "Закуски"
      key : "snack"
    salad:
      name : "Салаты"
      key : "salad"
    dessert:
      name : "Десерты"
      key : "dessert"
    bake:
      name : "Выпечка"
      key : "bake"
    drinks:
      name : "Напитки"
      key : "drinks"

  keyKitchen = $("#server-data").attr("keyKitchen")
  keySpecies = $("#server-data").attr("keySpecies")

  $("#img-cont > div").click (e) ->
    txt = $(@).text()
    key = $(@).attr("id")
    $("#header-kitchen").text(txt.toLowerCase())

    $.ajax
      type    : 'get'
      data    : {keySpecies:keySpecies,keyKitchen:key}
      url     : "/kitchen/speciesPage"
      success : (status) ->
        console.log "OF"
  if keyKitchen == "all"
    $("#russian").click()

  checkSpecies = specObj[keySpecies]
  $("#header-species").text(checkSpecies.name)

