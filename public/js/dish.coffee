$(document).ready () ->

  class CommentView extends Backbone.View
    
    
    tagName: 'div'
    
    className: 'comment-item'
    
    template: _.template(jQuery('#CommentTemplate').html()),

    initialize:(@options) ->

    render: ->
      $ = jQuery
      $(@el).html(@template({}));
      @



  user = JSON.parse $("#hide-input").attr("dataUser")
  dish = JSON.parse $("#hide-input").attr("dataDish")
  $("#hide-input").remove()
  console.log "use", user
  console.log "dish", dish
  
  
  $("#send-message").click ()->
    message = $("#message").val()
    if message
      objSend = { 
        userId:user._id
        message:message
        dishId:dish._id
      }
      $.ajax
        type    : 'POST'
        data    : objSend
        url     : "/comment/create"
        success : (status) ->
          if status == "OK"
            model = 
              user: user
              message:message
            commentView = new CommentView(model)
            console.log "heare"
            $("#comment-block").append(commentView.render().el)
