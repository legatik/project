$(document).ready () ->
  class DishView extends Backbone.View


    tagName: 'div'

    className: 'dish-book'

    template: _.template(jQuery('#dishBookTemplate').html()),

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
      $ = jQuery
      console.log "@model",@model
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
      $ = jQuery
      key =
        kitchen : @mitchingK[@model.kitchen]
        species : @mitchingS[@model.species]
      $(@el).html(@template({data:@model, key:key}));
      @


  app = {}
  obj = {}
  $.ajax
    type: "GET"
    url: "/kitchenGet/russian"
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
        console.log "id",$(id)
        console.log "data",data
        data.vtor.forEach (model) ->
          dishBookView = new DishView({model:model})
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
    key = id + "Arr"
    console.log "obj[key]",obj[key]
    testArr = obj[key]
    newArr = _.difference testArr.perv, testArr.vtor

