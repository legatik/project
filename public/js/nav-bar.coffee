$(document).ready () ->
    console.log "HEAREEEEEEEEEEEE"
    autoCompliteDish = (val) ->
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

    autoCompliteDish()

