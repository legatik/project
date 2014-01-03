db = require '../lib/db'
_ = require 'underscore'

{Dish} = db.models

exports.boot = (app) ->
  app.get '/popular_dish',  (req, res) ->
    Dish.find({})
    .limit(10)
    .sort({rating: -1})
    .exec (err, dishes) ->
      res.send {err: err, result: dishes}

