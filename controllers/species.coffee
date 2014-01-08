_ = require('underscore')
db = require '../lib/db'
exec = require('child_process').exec
{Dish} = db.models
exports.boot = (app) ->

  app.get '/speciesPage', (req, res) ->
    keySpecies = req.query.keySpecies
    keyKitchen = req.query.keyKitchen
    {keyKitchen, keySpecies} = app.mitching(keyKitchen, keySpecies, true)
    if keySpecies.name == "Первые блюда" then keySpecies.name = "Супы"
    Dish.find({$and: [{kitchen: keyKitchen.name}, {species: keySpecies.name}]}).exec (err, dish) ->
      res.send dish

  app.get '/speciesDate', (req, res) ->
    keySpecies = req.query.keySpecies
    {keySpecies} = app.mitching("all", keySpecies, true)
    if keySpecies.name == "Первые блюда" then keySpecies.name = "Супы"
    Dish.find({species:keySpecies.name})
    .limit(3)
    .sort({dateAdding: -1})
    .exec (er, dishDate) ->
      res.send dishDate


  app.get '/speciesPop', (req, res) ->
    keySpecies = req.query.keySpecies
    {keySpecies} = app.mitching("all", keySpecies, true)
    if keySpecies.name == "Первые блюда" then keySpecies.name = "Супы"
    Dish.find({species:keySpecies.name})
    .limit(3)
    .sort({rating: -1})
    .exec (err, dishPop) ->
      res.send dishPop
