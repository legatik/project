define [
], () ->

  class AclView extends Backbone.View
    
    
    tagName: 'div'
    
    id: 'acl-container'
    
#    template: JST["admin/public/templates/acl"]

    initialize:(@options) ->
      $ = jQuery
      console.log "index", ($('#sMContTemplate').html())
      
#    events:
#      "change .li-method" : "checkApi",
#      "change .check-api"  : "changeApi"
      

    render: ->
      @

