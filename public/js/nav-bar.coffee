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

  $("#close-login").click () ->
    $("#login-reg-blok").fadeOut 'slow', () ->
      $("#headerbg").css("overflow","hidden")
      $("#headerbg").animate
        height: 166
      , 700

  $("#sing-up-button").click () ->
    openWindow('reg-cont-show')
  $("#login-button").click () ->
    openWindow('login-cont-show')

    

    
      
  openWindow = (className) ->      
    $("#login-reg-blok").addClass(className)
    $("#headerbg").stop(true, true)
    $("#login-reg-blok").stop(true, true)
    $("#headerbg").animate
      height: 309
    , 700, () ->
      $("#login-reg-blok").hide().fadeIn 'slow'
  
  $("#loginbutton").click () ->
    $("#login-send").submit()
