$(document).ready () ->



  app = {}
  obj = {}
  
  keyKitchen = $("#hidden-data").attr("key")
  
  $.ajax
    type: "GET"
    url: "/kitchenGet/kitchenPage/" + keyKitchen
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
      $($("#"+id).find(".showAll")).text("показать все")
      $("#"+id).animate
        height:281
      , 500
    else
      $($("#"+id).find(".showAll")).text("скрыть")
      height = $($("#"+id).find(".dishBook")).css("height")
      height = (Number height.replace("px",""))+ 71
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

