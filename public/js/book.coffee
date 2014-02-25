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
      @mitchingK["Арабская"] = "arab"
      @model = @options.model
      @openBook = false
      @titleBolshe = 0
      @contAnimateTxt = false
      @progressBook = false
      @progressFlag = false

    events:
      "click .peview-dish"      : "goDishPage",
      "click .book-view"        : "makeBook",
      "click .raiting"          : "raitingSend",
      "mouseenter .flag-img"    : "hoverFlagOn",
      "mouseleave .flag-img"    : "hoverFlagOff",
      "mouseenter .book-view"   : "hoverBookOn",
      "mouseleave .book-view"   : "hoverBookOff",
      "click .flag-img"         : "clickFlag",
      "mouseenter"              : "beginAnimateTxt",
      "mouseleave"              : "endAnimateTxt"

    goDishPage: () =>
      window.location.href = "/kitchen/"+ @mitchingK[@model.kitchen] + "/" + @mitchingS[@model.species] + "/" + @model["_id"] + "/false"
    hoverBookOn: () =>
      if !@progressBook
        @progressBook = true
        $(".book-view", @el).animate
          width  : 55
        , 300, () =>
          @progressBook = false
        $(".book-view", @el).parent().animate
          left : -5
        , 300
        $(".book-view", @el).parent().parent().animate
          top : -10
        , 300


    hoverBookOff: () ->
        $(".book-view", @el).animate
          width  : 50
        , 300, () =>
        $(".book-view", @el).parent().animate
          left : 0
        , 300
        $(".book-view", @el).parent().parent().animate
          top : -5
        , 300

    beginAnimateTxt: () ->
      @contAnimateTxt = true
      @animateTitleTxt()
      
    endAnimateTxt: () ->
      @contAnimateTxt = false
#      $("#title-text", @el).stop(true,true)
#      $("#title-text", @el).animate
#        left : 0
#      , 100
      
    animateTitleTxt: () ->
      if $("#title-text", @el).length && @contAnimateTxt
        text = Number(($("#title-text", @el).css("width")).replace("px",""))
        cont = Number(($("#title-dish", @el).css("width")).replace("px",""))
        $("#title-text", @el).stop(true)
        
        textLeng = ($("#title-text", @el).text()).length
        
        timeout = 800
        
        if textLeng > 29 then  timeout = 1600
        
        if textLeng > 35 then  timeout = 1800
        
        self = @
        @titleBolshe = text - cont
        if @titleBolshe > 0
          $("#title-text", @el).animate
            left : @titleBolshe*(-1)
          , timeout,() ->
            setTimeout (=>
              $(@).animate
                left : 0
              , 
                duration: 400
                complete: ->
                  self.animateTitleTxt()
            ), 300
        
        
        

    hoverFlagOff: () ->
      $flagCont = $(".flag-img", @el).parent()
      $($flagCont).animate
        top:159
      , 300
      $(".flag-img", @el).animate
        width: 45
      , 300

    hoverFlagOn: () =>
      if !@progressFlag
        @progressFlag = true
        
        $flagCont = $(".flag-img", @el).parent()
        $($flagCont).animate
          top:149
        , 300, () =>
          @progressFlag = false
        $(".flag-img", @el).animate
          width: 60
        , 300
    
    clickFlag: (e) ->
      e.stopPropagation()
      window.location.href = "/kitchen/"+ @mitchingK[@model.kitchen]
      

    makeBook : (e) ->
      e.stopPropagation()
      if !@openBook
        @turn()
        @openBook = true
      $(".bookModel",@el).modal()

    raitingSend:(e) =>
      link = $(e.currentTarget).attr("link")
      $.ajax
        url: link
        success: (data) =>
          if data.status
           $("#index-raiting",@el).text(data.rating)

    turn: () =>
      $(".book",@el).turn
        width: 600
        height:300
        display: 'double'
        gradients: not $.isTouch
        elevation: 50
        when:
          turned: (e, page) ->

    rasparseStep: ->
      recipeWithPic = []
      pic_equal = @model.pic_equal.split(",")
      recipe = @model.recipe
      recipe.forEach (recept) ->
            recipeWithPic.push {recept:recept,pic:false}
      pic_equal.forEach (eq, index) ->
        eqFind = Number(eq) - 1
        recipeWithPic[eqFind].pic = index.toString()
      @model.recipeWithPic = recipeWithPic
      

    render: ->
      $ = jQuery
      if @model.pic_equal then @rasparseStep()
#      @model.composition.push({col:"ts2",ing:"test"})
#      @model.composition.push({col:"ts3",ing:"test"})
#      @model.composition.push({col:"ts4",ing:"test"})
#      @model.composition.push({col:"ts5",ing:"test"})
#      @model.composition.push({col:"ts6",ing:"test"})
      
      if @model.composition.length > 11
        @model.compositionMore = true

      key =
        kitchen : @mitchingK[@model.kitchen]
        species : @mitchingS[@model.species]
      $(@el).html(@template({data:@model, key:key}));
      @

  window.DishView = DishView

