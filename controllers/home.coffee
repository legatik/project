db = require '../lib/db'
_ = require 'underscore'

{Dish} = db.models

exports.boot = (app) ->
  app.get '/date_dish',  (req, res) ->
    Dish.find({})
    .limit(3)
    .sort({dateAdding: -1})
    .exec (er, dishDate) ->
      res.send dishDate

