db = require '../lib/db'
_ = require 'underscore'
{Dish} = db.models

exports.boot = (app) ->
  app.get '/:id', (req, res) ->
    id = req.params.id
    Dish.findOne {_id: id}, (err, dish) ->
      if err
        console.log "tipo 404 (nuzno sdelat stranicy)"
        res.send 404
      else
        title = "Мировая кухня | "+ dish.title_key
        res.render 'dish-page', {title: title, user: req.user, kitchen:"all", dish:dish}
