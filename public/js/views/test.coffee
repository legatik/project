define [
], () ->

  class AclView extends Backbone.View
    
    
    tagName: 'div'
    
    id: 'acl-container'
    
#    template: JST["admin/public/templates/acl"]

    initialize:(@options) ->
      console.log "index"
      
#    events:
#      "change .li-method" : "checkApi",
#      "change .check-api"  : "changeApi"
      

    render: ->
      console.log "render"
      @

