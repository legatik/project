define [
  "turn"
], (turn) ->
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
      console.log "@mitchingK",@mitchingK
      console.log "@model.kitchen", @model.kitchen
      key =
        kitchen : @mitchingK[@model.kitchen]
        species : @mitchingS[@model.species]
      $(@el).html(@template({data:@model, key:key}));
      @
    
