_ = require('underscore')
db = require '../lib/db'
exec = require('child_process').exec
{Dish} = db.models
exports.boot = (app) ->

  app.get '/:kitchen', (req, res) ->
    #kitchen
    keyKitchen = req.params.kitchen
    {keyKitchen, objk, objs} = app.mitching(keyKitchen)
    rusName = objk[keyKitchen].name
    title = "Мировая кухня | " + rusName + " кухня"
    res.render 'kitchen', {title: title, user: req.user, loc:'searchIng', kitchens: objk, temp: rusName + " кухня", key : keyKitchen, species:objs}

  app.get '/:kitchen/:species/:dish/:random', (req, res) ->
    idDish = req.params.dish
    loc = ""
    if req.params.random == "true" then loc = "randomDish"
    
    Dish.findOne {_id: idDish}, (err, dish) ->
      if err
        console.log "tipo 404 (nuzno sdelat stranicy)"
        res.send 404
      else
        keyKitchen = req.params.kitchen
        keySpecies = req.params.species
        {keyKitchen, objk, objs} = app.mitching(keyKitchen, keySpecies)
        title = "Мировая кухня | "+ dish.title_key
        
        res.render 'dish-page', {title: title, user: req.user, kitchens: objk, species:objs , key : keyKitchen, dish:dish, loc: loc}
