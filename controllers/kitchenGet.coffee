_ = require('underscore')
db = require '../lib/db'
exec = require('child_process').exec
{Dish, User, Raiting} = db.models
exports.boot = (app) ->
  app.get '/kitchenPage/:country', (req, res) ->
    country = req.params.country
    {keyKitchen, keySpecies} = app.mitching(country, 'snack', true)
    Dish.find {kitchen: keyKitchen.name}, (err, dishes) ->
      res.send dishes


  app.get '/raiting/:dish/:st', (req, res) ->
    getClientIp = (req) ->
      x_ip = req.headers['x-forwarded-for']
      unless x_ip? then x_ip = req.connection.remoteAddress
      x_ip
    dish = req.params.dish
    st = req.params.st
    if req.user
      status = true
      req.user.dishRaiting.forEach (idDish)->
        if idDish.toString() == dish then status = false
      if status
        User.findOne {"_id":req.user["_id"]}, (err, user) ->
          user.dishRaiting.push(dish)
          user.save()
          Dish.findOne {"_id":dish}, (err, dish) ->
            tekRaiting = dish.rating
            if st == "true"
              if Number tekRaiting < 10 then tekRaiting++
            if st == "false"
              if Number tekRaiting != 0 then tekRaiting--
            dish.rating = tekRaiting
            dish.save()
            res.send {status:true, rating:tekRaiting }
      else
        res.send {status:false}
    else
       x_ip = getClientIp(req)
       console.log "x_ip",x_ip
      
#    Dish.find {kitchen: keyKitchen.name}, (err, dishes) ->
#      res.send dishes
