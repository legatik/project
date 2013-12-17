define [
], () ->

  class DishView extends Backbone.View
    
    
    tagName: 'div'
    
    className: 'dish-book'
    
    template: _.template(jQuery('#dishBookTemplate').html()),

    initialize:(@options) ->
#    events:
#      "change .li-method" : "checkApi",
#      "change .check-api"  : "changeApi"
      

    render: ->
      $ = jQuery
      $(@.el).html(this.template(this.model));
      @

