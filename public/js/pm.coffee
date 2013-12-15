$(document).ready () ->
  require [
    "cs!/../js/views/searchModeView"
  ], (TestView) ->
#todo - сделать что бы в начале фэйчились продукты, потом все остальное
#     - изменить категории в админки и бд, и здесь (<option>Прочее</option>) ["Яйца и молочные продукты"]
# после подредактировать html (search-category)
    @productsArr = []
    @arrComparison = []
    @arrComparison["Грибы"] = ".gribi"
    @arrComparison["Крупы и каши"] = ".krupa_oreh"
    @arrComparison["Молочные продукты"] = ".molochnie"
    @arrComparison["Фрукты и ягоды"] = ".frukti"
    @arrComparison["Овощи и зелень"] = ".ovochi"
    @arrComparison["Рыба и морепродукты"] = ".moreprodukti"
#    @arrComparison["Яйца и молочные продукты"]
    @arrComparison["Мясные продукты"] = ".maso"
    @arrComparison["Мука и мучные изделия"] = ".muchnie"
    @arrComparison["Добавки и витамины"] = ".dobavki"


    $("#start-search-btn").on "click", (e) =>
      e.preventDefault()
      collectDataSearch()

    $("#add-ing").on "click", (e) =>
      e.preventDefault()
      addIng()


    addEventRemoveIng = () ->
      $(".del-ing").unbind("click")
      $(".del-ing").on "click", (e) =>
        console.log "$(e.target)",$(e.target)
        key = $(e.target).attr("key")
        ings = $(key).attr("ing")
        ingDel = $($(e.target).parent()).find(".pm-ing").text()
        ings = ings.replace(ingDel, "")
        $(key).attr("ing",ings)
        if !ings
          $(key).hide() 
          $(key).css("opacity",0)
        $($(e.target).parent()).remove()
        keyOl = key + "-ol"
        keyCont = key + "-cont" 
        liArr = $(keyOl).find("li")
        console.log "liArr.length",liArr.length
        if liArr.length == 0 then $(keyCont).hide()
        
        


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


    autoCompliteIng = () =>
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
              return
            close: (event, ui) =>
              $("#pm-dish-ing").val("")
          })

    checkIng = (event,ui) ->
      eventIng = @productsArr.filter (item)->
        item.title is ui.item.label
      key = eventIng[0].species
      id = @arrComparison[key]
      
      listIng = $(id).attr("ing")
      if listIng.indexOf(ui.item.label) >= 0 
        alert("Вы уже добавили этот ингридиент")
        return
      $(id).show()
      $(id).css("opacity",1)
#      if !listIng
      listIng = listIng + ui.item.label 
#      else
#        listIng = listIng +  "," + ui.item.label
      listIng = $(id).attr("ing",listIng)
      addIng(ui.item.label, id)
      
    addIng = (newIng,key) =>
#      newIng = $("#pm-dish-ing").val()
#      if !newIng then return
      ol = key + "-ol"
      container = key + "-cont" 
      newIngEl = "<li><span class='pm-ing'>"+newIng+"</span><div class='del-ing' key="+key+">x</div></li>"
      $(ol).append(newIngEl)
      $(container).show()
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


    console.log $("#dobavki")
    $(".cooler-companent").on "mouseenter", (e)=>
      console.log "e",e.target
      classEl = $(e.target).attr("class")
      console.log "class",classEl
      return
      fonId = "#" + id + "-fon"
      console.log "fonId",fonId
      $(fonId).css("opacity",1)


    autoCompliteDish()
    autoCompliteIng()

