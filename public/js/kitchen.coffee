$(document).ready () ->
  app = {}
  $.ajax
    type: "GET"
    url: "/kitchenGet/russian"
    success: (data) ->
      app.dishes = data
      a = twoMas('Супы')
      console.log a

  twoMas = (category) ->
    perv = app.dishes.slice()
    perv = perv.filter (el) ->
      el.species == category
    perv[3].rating=11
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

