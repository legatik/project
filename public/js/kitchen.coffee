$(document).ready () ->
  app = {}
  $.ajax
    type: "GET"
    url: "/kitchenGet/russian"
    success: (data) ->
      app.dishes = data
      first_courseArr = twoMas('Супы')
      main_dishesArr  = twoMas('Вторые блюда')
      snackArr  = twoMas('Закуски')
      saladArr  = twoMas('Салаты')
      dessertArr  = twoMas('Десерты')
      bakeArr  = twoMas('Выпечка')
      drinksArr  = twoMas('Напитки')
      console.log "main_dishes",main_dishesArr
      console.log "first_course", first_courseArr
      console.log "snack",snackArr
      console.log "salad",saladArr
      console.log "dessert",dessertArr
      console.log "bake",bakeArr
      console.log "drinksArr",drinksArr

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

