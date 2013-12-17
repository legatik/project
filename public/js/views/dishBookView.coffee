define [
  "turn"
], (turn) ->
  class DishView extends Backbone.View
    
    
    tagName: 'div'
    
    className: 'dish-book'
    
    template: _.template(jQuery('#dishBookTemplate').html()),

    initialize:(@options) ->
      @model = @options.model
#    events:
#      "change .li-method" : "checkApi",
#      "change .check-api"  : "changeApi"
      

    makeBook: ->
       $ = jQuery
       $(@el).turn
          width: 400
          height: 100
          autoCenter: true


    render: ->
      $ = jQuery
      console.log "@model",@model
      $(@el).html(@template({data:@model}));
      @
    
