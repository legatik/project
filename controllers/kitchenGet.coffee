_ = require('underscore')
db = require '../lib/db'
exec = require('child_process').exec
{Dish} = db.models
exports.boot = (app) ->
  app.get '/:country', (req, res) ->
    country = req.params.country
    {keyKitchen, keySpecies} = app.mitching(country, 'snack', true)
    Dish.find {kitchen: keyKitchen.name}, (err, dishes) ->
      res.send dishes

