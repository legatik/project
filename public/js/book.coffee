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
      @openBook = false

    events:
      "click .peview-dish"      : "makeBook",
      "click .raiting"          : "raitingSend",
      "mouseenter .flag-img"    : "hoverFlagOn",
      "mouseleave .flag-img"    : "hoverFlagOff",
      "click .flag-img"         : "clickFlag"

    hoverFlagOff: () ->
      $flagCont = $(".flag-img", @el).parent()
      $($flagCont).animate
        top:159
      , 300
      $(".flag-img", @el).animate
        width: 45
      , 300

    hoverFlagOn: () ->
      $flagCont = $(".flag-img", @el).parent()
      $($flagCont).animate
        top:149
      , 300
      $(".flag-img", @el).animate
        width: 60
      , 300
    
    clickFlag: (e) ->
      e.stopPropagation()
      window.location.href = "/kitchen/"+ @mitchingK[@model.kitchen]
      

    makeBook: ->
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
        recipeWithPic[eqFind].pic = index
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

