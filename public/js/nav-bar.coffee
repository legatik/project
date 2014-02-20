$(document).ready () ->
  reqShow = false
  logShow = false
  
  jQuery.browser = {};
  jQuery.browser.mozilla = /mozilla/.test(navigator.userAgent.toLowerCase()) && !/webkit/.test(navigator.userAgent.toLowerCase());
  jQuery.browser.webkit = /webkit/.test(navigator.userAgent.toLowerCase());
  jQuery.browser.opera = /opera/.test(navigator.userAgent.toLowerCase());
  jQuery.browser.msie = /msie/.test(navigator.userAgent.toLowerCase());
  
  
  if jQuery.browser.mozilla
    $("#right-column").find(".column-header").addClass("ffx-right-header")
  
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
    $(".form-reg-func").stop(true)
    $("#login-send").fadeOut "slow", () ->
      $("#headerbg").animate
        height: 533
      , 300
      $("#login-reg-blok").animate
        height: 333
        width: 365
      , 400, () ->
        $("#reg-send").fadeIn 'slow'

  renderLog = () ->
    logShow = true
    reqShow = false
    $("#headerbg").stop(true, true)
    $("#login-reg-blok").stop(true, true)
    $(".form-reg-func").stop(true)
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
      openWindow('reg-cont-show', 533, "#reg-send")
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
    if $('#login-send').parsley( 'isValid')
      email = $("#textfield").val()
      pass = $("#textfield2").val()
      login(email, pass)

  $("#register").click (e) ->
    $("#sing-up-button").click()

  login = (email, pass) ->
    $.ajax
      url: "/login"
      method:"post"
      data: { email: email, password: pass}
      success: (st) ->
        if st
          window.location.reload()
        else
          $("#fail-reg").hide().fadeIn("slow")
          
  $(".input-new-sty").focus (e) ->
    id = $(@).attr("id")
    if id == "reg-email" then $("#repeat-email").fadeOut("slow")
    if id == "reg-nik" then $("#repeat-nik").fadeOut("slow")
    
  $("#regbutton").click () ->
    if $('#reg-send').parsley( 'isValid')
      $(".err-repeat").fadeOut("slow")
      data = {
        nickname  : $("#reg-nik").val()
        email     : $("#reg-email").val()
        password  : $("#inputPassword").val()
        firstName : $("#reg-fname").val()
        lastName  : $("#reg-lname").val()
      }
      $.ajax
        url: "/register"
        method:"post"
        data: data
        success: (d) ->
          if !d.status
            $("#repeat-email").fadeIn("slow") if d.data.email
            $("#repeat-nik").fadeIn("slow") if d.data.nickname
          else
            email = data.email
            pass  = data.password
            login(email, pass)
            
            
#{ nickname: 'e',
#  email: 'qwe@qwe.qwe',
#  password: 'qwe',
#  firstName: 'e',
#  lastName: 'w' }

    
  $("#center-column").mouseenter () ->
      $("#zoom-clases").hide()
      $("#zoom-clases-species").hide()
      $(".li-hover").removeClass("li-hover")
    
  $("#ul-cont").mouseleave (e) ->
    st = $(e.target).hasClass("hover-true")
    if !st
      $("#zoom-clases").hide()
      $(".li-hover").removeClass("li-hover")
     
     
  $(".li-kitcen").mouseenter (e) ->
    $("#zoom-clases").css("display","inline-block")
    number = Number $(e.target).attr("number")
    idFind = "#" + $(e.target).attr("idFind")
    heightHover = 8 + number*37
    $(".li-hover").removeClass("li-hover")
    $(idFind).addClass("li-hover")
    $("#zoom-clases").stop(true,true)
    $("#zoom-clases").animate
        top: heightHover
      , 180
        
    
  $("#ul-cont-species").mouseleave (e) ->
    st = $(e.target).hasClass("hover-true-species")
    if !st
      $("#zoom-clases-species").hide()
      $(".li-hover").removeClass("li-hover")

  $(".li-species").mouseenter (e) ->
    $("#zoom-clases-species").css("display","inline-block")
    number = Number $(e.target).attr("number")
    idFind = "#" + $(e.target).attr("idFind")

    if jQuery.browser.mozilla
      heightHover = 10 + number*33
    else
      heightHover = 11 + number*32
    $(".li-hover").removeClass("li-hover")
    $(idFind).addClass("li-hover")
    $("#zoom-clases-species").stop(true,true)
    $("#zoom-clases-species").animate
        top: heightHover
      , 180
        
  $("#search-global-btn").click () ->
    searchDish = $("#nav-dish-input").val()
    if searchDish
      window.location.href = "/search/dish/" + searchDish

  $("#nav-dish-input").keypress (e) ->
    $("#search-global-btn").click() if e.keyCode == 13
