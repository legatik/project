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

  class DishView extends Backbone.View
    tagName: 'div'

    className: 'dish-book'

    template: _.template($('#dishBookTemplate').html()),

    initialize:(@options) ->
      @mitchingS = []
      @mitchingS["Супы"] = "first_course"
      @mitchingS["Вторые блюда"] = "main_dishes"
      @mitchingS["Закуски"] = "snack"
      @mitchingS["Салаты"] = "salad"
      @mitchingS["Десерты"] = "dessert"
      @mitchingS["Выпечка"] = "bake"
      @mitchingS["Напитки"] = "drinks"

      @mitchingK = []
      @mitchingK["Русская"] = "russian"
      @mitchingK["Итальянская"] = "italy"
      @mitchingK["Грузинская"] = "georgia"
      @mitchingK["Французкая"] = "franch"
      @model = @options.model

    events:
      "click .peview-dish" : "makeBook",

    makeBook: ->
      $(".bookModel",@el).modal()
      $(".book",@el).turn
        width: 600
        height:300
        display: 'double'
        acceleration: true
        gradients: not $.isTouch
        elevation: 50
        when:
          turned: (e, page) ->

    render: ->
      key =
        kitchen : @mitchingK[@model.kitchen]
        species : @mitchingS[@model.species]
      $(@el).html(@template({data:@model, key:key}));
      @

  keyKitchen = $("#server-data").attr("keyKitchen")
  keySpecies = $("#server-data").attr("keySpecies")
  console.log "keyKitchen",keyKitchen
  console.log "keySpecies",keySpecies


  rus = specObj[keySpecies]
  $("#title-spec").text(rus.name)


  $.ajax
    type    : 'get'
    data    : {keySpecies:keySpecies}
    url     : "/species/speciesDate"
    success : (dishesDate) ->
      dishesDate.forEach (model) ->
        dishBookView = new DishView({model:model})
        $("#date-append").append(dishBookView.render().el)

  $.ajax
    type    : 'get'
    data    : {keySpecies:keySpecies}
    url     : "/species/speciesPop"
    success : (dishesPop) ->
      dishesPop.forEach (model) ->
        dishBookView = new DishView({model:model})
        $("#pop-append").append(dishBookView.render().el)

  $("#show-all").click () ->
    alert("показать все")




#      $("#dish-date-cont").empty()
#      dishes.forEach (model) ->
#        dishBookView = new DishView({model:model})
#        $("#dish-date-cont").append(dishBookView.render().el)
#  $("#img-cont > div").click (e) ->
#    txt = $(@).text()
#    key = $(@).attr("id")
#    $("#header-kitchen").text(txt.toLowerCase())

#    $.ajax
#      type    : 'get'
#      data    : {keySpecies:keySpecies,keyKitchen:key}
#      url     : "/species/speciesPage"
#      success : (dishes) ->
#        $("#dish-date-cont").empty()
#        dishes.forEach (model) ->
#          dishBookView = new DishView({model:model})
#          $("#dish-date-cont").append(dishBookView.render().el)

#  if keyKitchen == "all"
#    $("#russian").click()

#  checkSpecies = specObj[keySpecies]
#  $("#header-species").text(checkSpecies.name)

