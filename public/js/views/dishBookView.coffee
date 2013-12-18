define [
  "turn"
], (turn) ->
  class DishView extends Backbone.View
    
    
    tagName: 'div'
    
    className: 'dish-book'
    
    template: _.template(jQuery('#dishBookTemplate').html()),

    initialize:(@options) ->
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
      $(@el).html(@template({data:@model}));
      @
    
