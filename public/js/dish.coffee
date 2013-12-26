$(document).ready () ->

  class CommentView extends Backbone.View
    
    
    tagName: 'div'
    
    className: 'comment-item'
    
    template: _.template(jQuery('#CommentTemplate').html()),

    initialize:(@model) ->
    render: ->
      $ = jQuery
      $(@el).html(@template(@model));
      @



  user = JSON.parse $("#hide-input").attr("dataUser")
  dish = JSON.parse $("#hide-input").attr("dataDish")
  $("#hide-input").remove()
  
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
              idUser:[user] 
              message:message
            commentView = new CommentView(model)
            console.log "heare"
            $("#comment-block").append(commentView.render().el)
            
            
  renderComments = ()->
    $.ajax
      type    : 'GET'
      data    : {idComment:dish.comments}
      url     : "/comment/find"
      success : (comments) ->
        comments.forEach (comment) ->
          model = 
            idUser:[user] 
            message:comment.message
          commentView = new CommentView(model)
          $("#comment-block").append(commentView.render().el)
    
  renderComments()
