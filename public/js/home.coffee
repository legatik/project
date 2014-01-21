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
      "click .raiting"     : "raitingSend"

    makeBook: ->
      $ = jQuery
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

    render: ->
      $ = jQuery
      console.log '@model',@model
      
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
      @turn()
      @

  
  $('.carousel').find(".item").first().addClass("active")
  $('.carousel-indicators').find("li").first().addClass("active")
  $('.carousel').carousel()
  $.ajax
    url: "/date_dish"
    success: (data) =>
      data.forEach (model) ->
        dishBookView = new DishView({model:model})
        $("#dish-date-cont").append(dishBookView.render().el)

