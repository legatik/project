$(document).ready () ->
  require [
    "cs!/../js/views/searchModeView"
  ], (TestView) ->

    setTimeOutDish =false

      
    $("#pm-dish-input").on "keypress", (e) =>
      setTimeOutDish && clearTimeout(setTimeOutDish)
      setTimeOutDish  = setTimeout (->
          autoCompliteDish()
          console.log "setTimeOutDish",setTimeOutDish
        ), 500
            
    $("#pm-dish-ing").on "keypress", (e) =>
      setTimeOutDish && clearTimeout(setTimeOutDish)
      setTimeOutDish  = setTimeout (->
          autoCompliteIng()
          console.log "setTimeOutDish",setTimeOutDish
        ), 500



    autoCompliteDish = (a) ->
      console.log("autoCompliteDish")


    autoCompliteIng = (a) ->
      console.log("autoCompliteIng")

