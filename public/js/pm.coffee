$(document).ready () ->
  require [
    "cs!/../js/views/searchModeView"
  ], (TestView) ->

    setTimeOutDish = false
#/^sd/
#      
#    $("#pm-dish-ing").on "keypress", (e) =>
#      setTimeOutDish && clearTimeout setTimeOutDish
#      
      
      
    autoCompliteDish = (val) ->
      $("#pm-dish-input").autocomplete
        source: (request, response) ->
          $.ajax
            url: "/search/title_complete"
            data: {title: $("#pm-dish-input").val()}
            success: (data) ->
              console.log data
              response $.map(data.result, (item) ->
                console.log("sss",item)
                label: item
              )
        minLength: 2
    

    autoCompliteIng = (a) ->
      $.ajax
        url: "/search/ing_complete"
        success: (data) ->
          console.log "data",data.result
          $("#pm-dish-ing").autocomplete({source:data.result, minLength: 2})
          
          
    $("#start-search-btn").on "click", (e) =>
      e.preventDefault()
      collectDataSearch()
      
    collectDataSearch = () ->
      
      searchDatasent = 
        title: $("#pm-dish-input")
      
      
      
          
    autoCompliteDish()
    autoCompliteIng()
    
