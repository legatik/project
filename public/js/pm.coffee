$(document).ready () ->
  require [
    "cs!/../js/views/searchModeView"
  ], (TestView) ->
#todo - сделать что бы в начале фэйчились продукты, потом все остальное
#     - изменить категории в админки и бд, и здесь (<option>Прочее</option>)
    @productsArr = []
    @arrComparison = []
    @arrComparison["Грибы"] = "#gribi"
    @arrComparison["Крупы и каши"] = "#krupa_oreh"
    @arrComparison["Молочные продукты"] = "#molochnie"
    @arrComparison["Фрукты и ягоды"] = "#frukti"
    @arrComparison["Овощи и зелень"] = "#ovochi"
    @arrComparison["Рыба и морепродукты"] = "#moreprodukti"
    @arrComparison["Яйца и молочные продукты"]
    @arrComparison["Мясные продукты"] = "#maso"
    @arrComparison["Мука и мучные изделия"] = "#muchnie"
    @arrComparison["Добавки и витамины"] = "#dobavki"


    $("#start-search-btn").on "click", (e) =>
      e.preventDefault()
      collectDataSearch()

    $("#add-ing").on "click", (e) =>
      e.preventDefault()
      addIng()


    addEventRemoveIng = () ->
      $(".del-ing").unbind("click")
      $(".del-ing").on "click", (e) =>
        $($(e.target).parent()).remove()


    autoCompliteDish = (val) ->
      $("#pm-dish-input").autocomplete
        source: (request, response) ->
          $.ajax
            url: "/search/title_complete"
            data: {title: $("#pm-dish-input").val()}
            success: (data) ->
              console.log data
              response $.map(data.result, (item) ->
                label: item
              )
        minLength: 2


    autoCompliteIng = (a) =>
      $.ajax
        url: "/search/ing_autcomplete1"
        success: (data) =>
          @productsArr = data.result
          arrTitle = data.result.map (product) ->
            product.title
          $("#pm-dish-ing").autocomplete({
            source:arrTitle,
            minLength: 2,
            select: (event, ui) =>
              checkIng(event, ui)
          })

    checkIng = (event,ui) ->
      console.log "heare"
      eventIng = @productsArr.filter (item)->
        item.title is ui.item.label
      key = eventIng[0].species
      id = @arrComparison[key]
      $(id).css("opacity",1)
      
      
    addIng = () =>
      newIng = $("#pm-dish-ing").val()
      if !newIng then return
      newIngEl = "<li><span class='pm-ing'>"+newIng+"</span><div class='del-ing'>x</div></li>"
      $("#pm-ing-ul").append(newIngEl)
      addEventRemoveIng()
      $("#pm-dish-ing").val("")
      $("#pm-dish-ing").focus()


    collectDataSearch = () ->
      #species
      speciesArr = $("#pm-species > input[type='checkbox']:checked")
      speciesSend = []
      i = 0
      while i < speciesArr.length
        speciesSend.push($(speciesArr[i]).attr("name"))
        i++

      # ing

      ingArr = $(".pm-ing")
      ingSend = []
      i = 0
      while i < ingArr.length
        ingSend.push($(ingArr[i]).text())
        i++

      #todo добавить массив ингридиетнов

      searchDatasent =
        title        : $("#pm-dish-input").val()
        kitchen      : $("#selectKitchen").val()
        species      : speciesSend
        ing          : ingSend
        time_cooking : $("#time-cooke").val()
        cost         : $("#cost").val()
        complexity   : $("#complexity").val()
        rating       : $("#rating").val()
        kremling_diet : $("#kremling_diet").val()

      console.log "searchDatasent",searchDatasent
      $.ajax
        type: 'POST'
        url: "/search/DishesReq"
        data: searchDatasent
        success: (data) ->
          console.log 'success', arguments






    autoCompliteDish()
    autoCompliteIng()

