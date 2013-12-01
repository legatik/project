$(document).ready () ->
  require [
    "cs!/../js/views/searchModeView"
  ], (TestView) ->

    setTimeOutDish = false
#/^sd/
      
    $("#pm-dish-input").on "keypress", (e) =>
      setTimeOutDish && clearTimeout setTimeOutDish
      setTimeOutDish  = setTimeout (->
          autoCompliteDish()
          console.log "setTimeOutDish",setTimeOutDish
          $.ajax
            type: "GET"
            url: "/search/title_complete"
            data: {title: $(e.target).val()}
            success: (res) ->
              autoCompliteDish res.result     
          
          
        ), 1000
            
#    $("#pm-dish-ing").on "keypress", (e) =>
#      setTimeOutDish && clearTimeout(setTimeOutDish)
#      setTimeOutDish  = setTimeout (->
#          autoCompliteIng()
#          console.log "setTimeOutDish",setTimeOutDish
#        ), 500

    

    autoCompliteDish = (dishes) ->
      console.log("autoCompliteDish", dishes)
      $("#pm-dish-input").autocomplete({
        source: dishes
      });

    autoCompliteIng = (a) ->
      console.log("autoCompliteIng")

