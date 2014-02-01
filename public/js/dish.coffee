$(document).ready () ->
  class CommentView extends Backbone.View


    tagName: 'div'

    className: 'comment-item'

    template: _.template(jQuery('#CommentTemplate').html()),

    initialize:(@model) ->
    
    replaceSmail: ->
      textMess = $(".message-user", @el).text()
      textMess = textMess.replace(/:-\|/g,"<img src='/img/images/smails/dumbfounded.png'>")
      textMess = textMess.replace(/:-\)\)/g,"<img src='/img/images/smails/big_grin.png'>")
      textMess = textMess.replace(/:-\)/g,"<img src='/img/images/smails/happy.png'>")
      textMess = textMess.replace(/8-P/g,"<img src='/img/images/smails/crazy.png'>")
      textMess = textMess.replace(/:-]/g,"<img src='/img/images/smails/appalled.png'>")
      textMess = textMess.replace(/;-\(/g,"<img src='/img/images/smails/evil.png'>")
      textMess = textMess.replace(/:-o/g,"<img src='/img/images/smails/pipe.png'>")
      textMess = textMess.replace(/:sleep:/g,"<img src='/img/images/smails/sleep.png'>")
      $(".message-user", @el).html(textMess)
      
    
    
    render: ->
      $ = jQuery
      $(@el).html(@template(@model));
      @



  jQuery.fn.extend insertAtCaret: (myValue) ->
    @each (i) ->
      if document.selection
        
        # Для браузеров типа Internet Explorer
        @focus()
        sel = document.selection.createRange()
        sel.text = myValue
        @focus()
      else if @selectionStart or @selectionStart is "0"
        
        # Для браузеров типа Firefox и других Webkit-ов
        startPos = @selectionStart
        endPos = @selectionEnd
        scrollTop = @scrollTop
        @value = @value.substring(0, startPos) + myValue + @value.substring(endPos, @value.length)
        @focus()
        @selectionStart = startPos + myValue.length
        @selectionEnd = startPos + myValue.length
        @scrollTop = scrollTop
      else
        @value += myValue
        @focus()









  $("#login-footer").click () ->
    $("html, body").animate
      scrollTop: 0
    , 1000, () ->
      $("#login-button").click()

  $("#reg-footer").click () ->
    $("html, body").animate
      scrollTop: 0
    , 1000, () ->
      $("#sing-up-button").click()

  $(".pic-smile").click (e) ->
    txtSmile = $(e.target).attr("txtSmile")
    $('#message').insertAtCaret(txtSmile);

# Only logined user
  if $("#hide-input").length == 0 then return
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
            $("#comment-block").append(commentView.render().el)
            commentView.replaceSmail()


  renderComments = ()->
    $.ajax
      type    : 'GET'
      data    : {idComment:dish.comments}
      url     : "/comment/find"
      success : (comments) ->
        if comments
          comments.forEach (comment) ->
            model =
              idUser:[user]
              message:comment.message
            commentView = new CommentView(model)
            $("#comment-block").append(commentView.render().el)
            commentView.replaceSmail()
        else 
           $("#comment-block").text("Ваш коментарий может быть первый")

  renderComments()
