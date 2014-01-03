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

  app.get '/', (req, res) ->
    Dish.find({})
    .limit(10)
    .sort({rating: -1})
    .exec (err, dishPop) ->
      {keyKitchen, objk, objs} = app.mitching()
      res.render 'index', {title: 'Мировая кухня', user: req.user, loc:'home', kitchens: objk, species:objs, key:keyKitchen, popDish:dishPop}

  app.get '/addDish',  (req, res) ->
    {keyKitchen, objk, objs} = app.mitching()
    res.render 'add_dish', {title: 'Мировая кухня - Добавить блюдо', user: req.user, loc:'addDish', kitchens: objk, species:objs, key:keyKitchen}

