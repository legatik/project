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
    $("#login-blok").fadeOut 'slow', () ->
      $("#headerbg").css("overflow","hidden")
      $("#headerbg").animate
        height: 166
      , 700
      
  $("#login-button").click () ->
    $("#headerbg").stop(true, true)
    $("#login-blok").stop(true, true)
    $("#headerbg").animate
      height: 309
    , 700, () ->
      $("#login-blok").hide().fadeIn 'slow'
