db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs'

{Dish, Product} = db.models

exports.boot = (app) ->
  app.get '/ing', (req, res) ->
    {keyKitchen, objk, objs} = app.mitching()
    res.render 'search_ing', {title: 'Мировая кухня | Поиск по инргридиентам', user: req.user, loc:'searchCategory', key : keyKitchen, kitchens: objk, species:objs}

#  app.get '/category', (req, res) ->
#    {keyKitchen, objk, objs} = app.mitching()
#    res.render 'search_category', {title: 'Мировая кухня | Поиск по инргридиентам', user: req.user, loc:'searchCategory', key : keyKitchen, kitchens: objk, species:objs}


  app.get '/title_complete',  (req, res) ->
#    console.log('HELLOOOO TIIIITTTLLLEEEE', req.query)
    find = new RegExp(req.query.title, "i")
  #	  find = '/'+req.query.title+'/'
    dish = Dish.find {title: find}, (err, dishes) ->
      dishes = dishes.map (dish) ->
        dish.title
      res.send {err: err, result: dishes}

  app.get '/ing_autcomplete1',  (req, res) ->
    Product.find {}, (err, arrProducts) ->
      res.send {err: err, result: arrProducts}


  app.post '/DishesReq', (req, res) ->
    ProductsList = []
    ExProductsList = []
    species = []
    ProductsList = req.body.ing  if req.body.ing
    ExProductsList = req.body.exproducts  if req.body.exproducts
    species = req.body.species  if req.body.species
    filter = {}
    filter.kitchen = req.body.kitchen  if req.body.kitchen
    filter.cost = req.body.cost  if req.body.cost
    if species.length isnt 0
      filter.species =
        $in: species
    filter.time_cooking = +req.body.time_cooking  if req.body.time_cooking
    filter.rating = +req.body.rating  if req.body.rating
    filter.kremling_diet = req.body.kremling_diet  if req.body.kremling_diet
    console.log 'filter',filter
    if ProductsList.length isnt 0 and ExProductsList.length isnt 0
      filter.ingredients =
        $in: ProductsList
        $nin: ExProductsList
    else unless ProductsList.length is 0
      filter.ingredients = $in: ProductsList
    else filter.ingredients = $nin: ExProductsList  unless ExProductsList.length is 0
    console.log filter
    dish = Dish.find filter, (err, dishes) ->
      result = dishes.sort((a, b) ->
        x = _.intersection(req.body.ing, a.get("ingredients")).length
        y = _.intersection(req.body.ing, b.get("ingredients")).length
        console.log 'XY', x, y
        (if (x > y) then -1 else ((if (x is y) then 0 else 1)))
      )
      res.send(result)




#		project = _.extend req.body,
#			owner: req.user._id
#		Project.findOne {owner: req.user._id, name: project.name}, (err, p) ->
#			return 	res.redirect '/user/projects' if p
#			Project.create project, (err, project) ->
#				User.findById req.user._id, (err, user) ->
#					user.projects.push project._id
#					#path = [__dirname, '../projects', user._id, project._id].join '/'
#					#fs.mkdir path, '0777', (err) ->
#					user.save()
#					res.redirect '/user/projects'

