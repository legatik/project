$(document).ready () ->
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
      , 700

  $("#sing-up-button").click () ->
    openWindow('reg-cont-show', 526, "#reg-send")
  $("#login-button").click () ->
    openWindow('login-cont-show', 309, "#login-send")

    

    
      
  openWindow = (className, h, form) ->
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
