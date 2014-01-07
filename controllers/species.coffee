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

