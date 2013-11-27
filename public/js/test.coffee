$(document).ready () ->
#  define ['my/required/module'], (myModule) ->
#    alert()

  require [
    "cs!/../js/views/test"
  ], (TestView) ->
      testView  = new TestView()
      console.log("TestView",testView.render())
