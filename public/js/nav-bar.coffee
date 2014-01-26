$(document).ready () ->
  reqShow = false
  logShow = false
  $("#nav-dish-input").autocomplete
    source: (request, response) ->
      $.ajax
        url: "/search/title_complete"
        data: {title: $("#nav-dish-input").val()}
        success: (data) ->
          console.log data
          response $.map(data.result, (item) ->
            label: item
          )
    minLength: 2

  $(".close-window").click () ->
    $("#login-reg-blok").fadeOut 'slow', () ->
      $("#headerbg").css("overflow","hidden")
      $("#headerbg").animate
        height: 166
      , 500, () ->
        logShow = false
        reqShow = false


  renderReg = () ->
    logShow = false
    reqShow = true
    $("#headerbg").stop(true, true)
    $("#login-reg-blok").stop(true, true)
    $(".form-reg-func").stop(true, true)
    $("#login-send").fadeOut "slow", () ->
      $("#headerbg").animate
        height: 526
      , 300
      $("#login-reg-blok").animate
        height: 320
        width: 468
      , 400, () ->
        $("#reg-send").fadeIn 'slow'

  renderLog = () ->
    logShow = true
    reqShow = false
    $("#headerbg").stop(true, true)
    $("#login-reg-blok").stop(true, true)
    $(".form-reg-func").stop(true, true)
    $("#reg-send").fadeOut "slow", () ->
      $("#login-reg-blok").animate
        height: 110
        width: 649
      , 300
      $("#login-send").fadeIn 'slow'
      $("#headerbg").animate
        height: 309
      , 400

  $("#sing-up-button").click () ->
    if !reqShow and !logShow
      openWindow('reg-cont-show', 526, "#reg-send")
      reqShow = true
    if logShow
      renderReg()
  $("#login-button").click () ->
    if !reqShow and !logShow
      logShow = true
      openWindow('login-cont-show', 309, "#login-send")
    if reqShow
      renderLog()
    

    
      
  openWindow = (className, h, form) ->
    $("#login-reg-blok").attr("style","")
    $(".form-reg-func").hide()
    $("#login-reg-blok").removeClass("reg-cont-show")
    $("#login-reg-blok").removeClass("login-cont-show")      
    $("#login-reg-blok").addClass(className)
    $(form).show()
    $("#headerbg").stop(true, true)
    $("#login-reg-blok").stop(true, true)
    $("#headerbg").animate
      height: h
    , 700, () ->
      $("#login-reg-blok").hide().fadeIn 'slow'
  
  $("#loginbutton").click () ->
    $("#login-send").submit()
