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
    dishId = req.params.dish
    st = req.params.st
    if st != "false" and st != "true"
      res.send {status:false}
      return
    if st == "true" then st = true
    if st == "false" then st = false
    if req.user
#      Raiting.createThis(true, dish)
      User.findById(req.user["_id"])
      .populate('dishRaiting')
      .exec (err, user) ->
        Dish.findById dishId , (err ,dish) ->
          idRaiting = false
          raitingSt = ''
          user.dishRaiting.forEach (raiting)->
            if raiting.dish.toString() == dishId.toString() 
              idRaiting = raiting["_id"]
              raitingSt = raiting.st
          if idRaiting
            if !raitingSt == st
              tekRaiting = dish.rating
              if st
                if Number tekRaiting < 10 then tekRaiting++
              if !st
                if Number tekRaiting != 0 then tekRaiting--
              dish.rating = tekRaiting
              dish.save()
              Raiting.findById idRaiting, (err, raiting) ->
                if !err
                  raiting.st = st
                  raiting.save()
              res.send {status:true, rating:tekRaiting }
            else
              res.send {status:false}
          else
            Raiting.createThis st, dish, (crRaiting) ->
              tekRaiting = dish.rating
              if st
                if Number tekRaiting < 10 then tekRaiting++
              if !st
                if Number tekRaiting != 0 then tekRaiting--
              dish.rating = tekRaiting
              dish.save()
              user.dishRaiting.push(crRaiting["_id"])
              user.save()
              res.send {status:true, rating:tekRaiting }
              
#            res.send {status:true, rating:tekRaiting }
#      else
#        res.send {status:false}
      
#    Dish.find {kitchen: keyKitchen.name}, (err, dishes) ->
#      res.send dishes
