$(document).ready () ->


#  class DishView extends Backbone.View


#    tagName: 'div'

#    className: 'dish-book'

#    template: _.template(jQuery('#dishBookTemplate').html()),

#    initialize:(@options) ->
#      @mitchingS = []
#      @mitchingS["Супы"] = "first_course"
#      @mitchingS["Вторые блюда"] = "main_dishes"
#      @mitchingS["Закуски"] = "snack"
#      @mitchingS["Салаты"] = "salad"
#      @mitchingS["Десерты"] = "dessert"
#      @mitchingS["Выпечка"] = "bake"
#      @mitchingS["Напитки"] = "drinks"

#      @mitchingK = []
#      @mitchingK["Русская"] = "russian"
#      @mitchingK["Итальянская"] = "italy"
#      @mitchingK["Грузинская"] = "georgia"
#      @mitchingK["Французкая"] = "franch"
#      @model = @options.model

#    events:
#      "click .peview-dish" : "makeBook",

#    makeBook: ->
#      $ = jQuery
#      console.log "@model",@model
#      $(".bookModel",@el).modal()
#      $(".book",@el).turn
#        width: 600
#        height:300
#        display: 'double'
#        acceleration: true
#        gradients: not $.isTouch
#        elevation: 50
#        when:
#          turned: (e, page) ->


#    render: ->
#      $ = jQuery
#      key =
#        kitchen : @mitchingK[@model.kitchen]
#        species : @mitchingS[@model.species]
#      $(@el).html(@template({data:@model, key:key}));
#      @
  
  app = {}
  obj = {}
  $.ajax
    type: "GET"
    url: "/kitchenGet/kitchenPage/russian"
    success: (data) ->
      app.dishes = data
      obj.first_courseArr = twoMas('Супы')
      obj.main_dishesArr  = twoMas('Вторые блюда')
      obj.snackArr  = twoMas('Закуски')
      obj.saladArr  = twoMas('Салаты')
      obj.dessertArr  = twoMas('Десерты')
      obj.bakeArr  = twoMas('Выпечка')
      obj.drinksArr  = twoMas('Напитки')
      _.each obj, (data, key) ->
        id = "#" + key.replace("Arr","")
        data.vtor.forEach (model) ->
          dishBookView = new window.DishView({model:model})
          $($(id).find(".dishBook")).append(dishBookView.render().el)
        newArr = _.difference data.perv, data.vtor
        newArr.forEach (model) ->
          dishBookView = new window.DishView({model:model})
          $($(id).find(".dishBook")).append(dishBookView.render().el)
  twoMas = (category) ->
    perv = app.dishes.slice()
    perv = perv.filter (el) ->
      el.species == category
    if perv.length < 3
      vtor = perv
      return {perv, vtor}
    mostPopular = _.max perv, (el) ->
      el.rating
    perv.sort (el) ->
      el.dateAdding
    if (perv.indexOf(mostPopular) isnt perv.length-1)
      lastAdding = perv[perv.length-1]
    else
      lastAdding = perv[perv.length-2]
    isclInd = [perv.indexOf(mostPopular), perv.indexOf(lastAdding)]
    randDish = perv[getRandomInt(perv.length-1, isclInd)]
    vtor = [mostPopular, lastAdding, randDish]
    {perv, vtor}

  getRandomInt = (max, iscl) ->
    ceil = Math.floor(Math.random() * (max  + 1))
    if (iscl.indexOf(ceil) != -1)
      getRandomInt(max, iscl)
    else
      ceil

  $(".showAll").click (e) ->
    id = ($($(@).parent()).parent()).attr("id")
    $("#"+id).stop(true)
    status = $("#"+id).hasClass("collaps")
    if status
      status = $("#"+id).removeClass("collaps")
      $($("#"+id).find(".showAll > a")).text("показать все")
      $("#"+id).animate
        height:262
      , 500
    else
      $($("#"+id).find(".showAll > a")).text("скрыть")
      height = $($("#"+id).find(".dishBook")).css("height")
      height = (Number height.replace("px",""))+ 59
      $("#"+id).addClass("collaps")
      $("#"+id).animate
        height:height
      , 1000
#    key = id + "Arr"
#    console.log "obj[key]",obj[ke111y]
#    testArr = obj[key]
#    newArr = _.difference testArr.perv, testArr.vtor
#    $($("#"+id).find(".dishBook")).empty()
#    newArr.forEach (model)->
#      dishBookView = new window.DishView({model:model})
#      $($("#"+id).find(".dishBook")).append(dishBookView.render().el)

