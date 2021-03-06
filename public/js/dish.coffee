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
      textMess = textMess.replace(/:-o/g,"<img style='width: 35px;' src='/img/images/smails/pipe.png'>")
      textMess = textMess.replace(/:sleep:/g,"<img style='width: 32px;' src='/img/images/smails/sleep.png'>")
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
  dish = JSON.parse $("#hide-input").attr("dataDish")
  testUser = $("#hide-input").attr("dataUser")
  
  
  if testUser
# Only logined user
    user = JSON.parse $("#hide-input").attr("dataUser")
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
                dateAdded : new moment
              model.dateAdded = model.dateAdded.format("llll")
              commentView = new CommentView(model)
              $("#comment-block").prepend(commentView.render().el)
              $("#coment-title").text("Коментарии к блюду")
              commentView.replaceSmail()
              $("#message").val('')

    $(".raiting-url").on "click", (e) ->
      $.ajax
        type    : 'GET'
        url     : $(@).attr("url")
        success : (data) =>
          $(".not-select").removeClass("not-select")
          idNotCheck = "#" + $(@).attr("not-check")
          $(idNotCheck).addClass("not-select")
          console.log "status", data

    $(".raiting-url > img").on "mouseenter", (e) ->
      $(@).stop(true, true)
      $(@).animate
        width:34
        , 200 
    $(".raiting-url > img").on "mouseout", (e) ->
      $(@).stop(true, true)
      $(@).animate
        width:31
        , 200 


  renderComments = ()->
    dish.comments
    $.ajax
      type    : 'GET'
      data    : {idComment:dish.comments}
      url     : "/comment/find"
      success : (comments) ->
        console.log "comments",comments
        if comments
          comments.forEach (comment) ->
            model =
              idUser    : [comment.idUser[0]]
              message   : comment.message
              dateAdded : new moment comment.dateAdded
            model.dateAdded = model.dateAdded.format("llll")
            
            commentView = new CommentView(model)
            $("#comment-block").prepend(commentView.render().el)
            commentView.replaceSmail()
        else
            $("#coment-title").text("Ваш коментарий может стать первым!")

  renderComments()
