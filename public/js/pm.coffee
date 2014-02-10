$(document).ready () ->
  #todo - сделать что бы в начале фэйчились продукты, потом все остальное
#  class DisBookView extends Backbone.View
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
#      console.log "@mitchingK",@mitchingK
#      console.log "@model.kitchen", @model.kitchen
#      key =
#        kitchen : @mitchingK[@model.kitchen]
#        species : @mitchingS[@model.species]
#      $(@el).html(@template({data:@model, key:key}));
#      @

    firstObj = {
      species : true
      ing     : true
    }
    @skip = 0
    @searchDatasent = false
    @productsArr = []
    @arrComparison = []
    @arrComparison["Грибы"] = ".gribi"
    @arrComparison["Крупы и орехи"] = ".krupa_oreh"
    @arrComparison["Яйца и молочные продукты"] = ".molochnie"
    @arrComparison["Фрукты и ягоды"] = ".frukti"
    @arrComparison["Овощи и зелень"] = ".ovochi"
    @arrComparison["Рыба и морепродукты"] = ".moreprodukti"
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
      
      #for del
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




#    autoCompliteDish = (val) ->
#      $("#pm-dish-input").autocomplete
#        source: (request, response) ->
#          $.ajax
#            url: "/search/title_complete"
#            data: {title: $("#pm-dish-input").val()}
#            success: (data) ->
#              console.log data
#              response $.map(data.result, (item) ->
#                label: item
#              )
#        minLength: 2


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

    checkIng = (event,ui) =>
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
      newIngEl = "<li><div class='del-ing' key="+key+">x</div><span class='pm-ing'>"+newIng+"</span></li>"
      $(ol).append(newIngEl)
      $(container).show()
      addEventRemoveIng()
      $("#pm-dish-ing").val("")
      $("#pm-dish-ing").focus()


    collectDataSearch = () =>
      #species
      speciesArr = $(".species-searh")
      speciesSend = []
      i = 0
      while i < speciesArr.length
        if($(speciesArr[i])).hasClass("checked")
          speciesSend.push($(speciesArr[i]).text())
        i++

      # ing

      ingArr = $(".pm-ing")
      ingSend = []
      i = 0
      while i < ingArr.length
        ingSend.push($(ingArr[i]).text())
        i++

      #todo добавить массив ингридиетнов

      @searchDatasent =
        kitchen      : $("#selectKitchen").val()
        species      : speciesSend
        ing          : ingSend
        time_cooking : $("#time-cooke").val()
        cost         : $("#cost").val()
        complexity   : $("#complexity").val()
        rating       : $("#rating").val()
        kremling_diet : $("#kremling_diet").val()

      @skip = 0
      requestDish(@searchDatasent, @skip)

#      if !searchDatasent.ing.length
#        alert("Ваш холодильник пустой. Мы не можем предложить вам ни одного рецепта")
#        return

    requestDish = (searchDatasent, skip) =>
      searchDatasent.skip = skip
      $.ajax
        type: 'POST'
        url: "/search/DishesReq"
        data: searchDatasent
        success: (data) =>
          $("#dishBookAppender").empty()
          renderDish(data)
          @skip = 15
          
          
    inProgress = false
    $(window).scroll =>
      if $(window).scrollTop() + $(window).height() >= $(document).height() - 250 and not inProgress and @searchDatasent
        @searchDatasent.skip = @skip
        $.ajax(
          type: 'POST'
          url: "/search/DishesReq"
          data: @searchDatasent
          beforeSend: =>
            inProgress = true
        ).done (data) =>
          renderDish(data)
          @skip = @skip + 15
          inProgress = false
    


    renderDish = (data) ->
      data.forEach (model) ->
        dishBookView = new window.DishView({model:model})
        $("#dishBookAppender").append(dishBookView.render().el)
        $(dishBookView.el).hide(0).fadeIn('slow')

    $(".cooler-companent").on "mouseenter", (e)=>
      classEl = $(e.target).attr("fonClass")
      console.log "class",classEl
      classPic = classEl + "-fon"
      $(classPic).css("opacity",1)
      listEl = classEl + "-cont"
#      $(listEl).addClass("red-color")
      $(listEl).find(".pm-ing").css("color","#DE505F")


    $(".cooler-companent").on "mouseout", (e)=>
      classEl = $(e.target).attr("fonClass")
      console.log "class",classEl
      classPic = classEl + "-fon"
      $(classPic).css("opacity",0)
      listEl = classEl + "-cont"
#      $(listEl).removeClass("red-color")
      $(listEl).find(".pm-ing").css("color","black")

    $(".species-searh").on "click", (e) ->
      if firstObj.species
          $(".species-searh").removeClass("checked")
          firstObj.species = false
      if $(@).hasClass("checked")
        if $(".checked").length != 1
          $(@).removeClass("checked")
        else
          $(@).removeClass("checked")
          $(".species-searh").addClass("checked")
      else
        $(@).addClass("checked")
    $(".species-searh").addClass("checked")

    $(".ob-cont-ing > ol").mouseenter (e) ->
        $(@).find(".pm-ing").css({cursor:"default",color:"#DE505F"})
        className =  $(@).attr("class")
        key = className.replace("-ol", "")
        key = "." + key + "-fon"
        $(key).css("opacity", 1)


    $(".ob-cont-ing > ol").mouseleave (e) ->
      $(@).find(".pm-ing").css({cursor:"default",color:"black"})
      className =  $(@).attr("class")
      key = className.replace("-ol", "")
      key = "." + key + "-fon"
      $(key).css("opacity", 0)

    $("#time-cooke").ionRangeSlider
        min: 0,
        max: 720,
        from: 0,
        to: 720,
        type: 'double',
        step: 1,
        prefix: "минут ",
        prettify: true,
        hasGrid: true,
        onChange: (ob) ->
          $("#time-ind-min").html(ob.toNumber)
          $("#time-ind-max").html(ob.fromNumber)

    $("#rating").ionRangeSlider
        min: 0,
        max: 100,
        from: 0,
        to: 100,
        type: 'double',
        step: 1,
        prettify: true,
        hasGrid: true
        onChange: (ob) ->
          $("#pop-ind-min").html(ob.toNumber)
          $("#pop-ind-max").html(ob.fromNumber)

    $("#kremling_diet").ionRangeSlider
        min: 0,
        max: 100,
        from: 0,
        to: 100,
        type: 'double',
        step: 1,
        prettify: true,
        hasGrid: true
        onChange: (ob) ->
          $("#kr-ind-min").html(ob.toNumber)
          $("#kr-ind-max").html(ob.fromNumber)

    $("#complexity").ionRangeSlider
        min: 0,
        max: 10,
        from: 0,
        to: 10,
        type: 'double',
        step: 1,
        prettify: true,
        hasGrid: true
        onChange: (ob) ->
          $("#com-ind-min").html(ob.toNumber)
          $("#com-ind-max").html(ob.fromNumber)

#    autoCompliteDish()
    autoCompliteIng()

