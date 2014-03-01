_ = require('underscore')
db = require '../lib/db'
exec = require('child_process').exec
{Dish, User} = db.models
exports.boot = (app) ->

  app.get '/:kitchen', (req, res) ->
    #kitchen
    keyKitchen = req.params.kitchen
    {keyKitchen, objk, objs} = app.mitching(keyKitchen)
    rusName = objk[keyKitchen].name
    title = "Мировая кухня | " + rusName + " кухня"
    res.render 'kitchen', {title: title, user: req.user, loc:'searchIng', kitchens: objk, temp: rusName + " кухня", key : keyKitchen, species:objs, metaKey:""+rusName.toLowerCase() + ", "+rusName.toLowerCase()+" кухня, зарубежная, рецепты, вкусная, простая, приготовление", description: ""+rusName + " кухня. Вкуснейшие рецепты любой сложности с картинками шагов приготовления!"}

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
        rusName = objk[keyKitchen].name
        title = dish.title_key
        stLike = 'no-check'
        if req.user
          User.findById(req.user["_id"])
          .populate('dishRaiting')
          .exec (err, user) ->
            user.dishRaiting.forEach (raiting)->
              console.log "raiting",raiting
              if raiting.dish.toString() == idDish.toString() then stLike = raiting.st
            res.render 'dish-page', {title: title, user: req.user, kitchens: objk, species:objs , key : keyKitchen, dish:dish, loc: loc, stLike:stLike, description: dish.description, metaKey: dish.key + ", " + rusName.toLowerCase()+ " кухня"}
        else
          res.render 'dish-page', {title: title, user: req.user, kitchens: objk, species:objs , key : keyKitchen, dish:dish, loc: loc, stLike:stLike, description: dish.description, metaKey: dish.key + ", " + rusName.toLowerCase()+ " кухня"}
