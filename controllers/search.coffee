db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs'

{Dish, Product} = db.models

exports.boot = (app) ->

  app.get '/dish/:searchDish', (req, res) ->
    {keyKitchen, objk, objs} = app.mitching()
    searchDish = req.params.searchDish
    
    find = new RegExp(searchDish, "i")
    Dish.find({title: find})
    .limit(15)
    .exec (err, dishes) ->
      data = {
        title      : true
        dishes     : dishes
        searchDish : searchDish
      }
      data = JSON.stringify(data)
      res.render 'search_ing', {title: 'Мировая кухня | Поиск рецепта', user: req.user, loc:'searchCategory', key : keyKitchen, kitchens: objk, species:objs, serchTitle:data, metaKey:"суп, супы, итальянская кухня, арабская кухня, японская кухня", description: "Поиск рецептов с картинками шагов приготовления по ингридиентам"}
      
  app.get '/ing', (req, res) ->
    {keyKitchen, objk, objs} = app.mitching()
    data = {
      title  : false
      dishes : []
    }
    data = JSON.stringify(data)
    res.render 'search_ing', {title: 'Мировая кухня | Поиск по инргридиентам', user: req.user, loc:'searchIng', key : keyKitchen, kitchens: objk, species:objs, serchTitle:data, metaKey:"мировая кухня, поиск по ингредиентам, салаты, рецепты кулинарии, французская кухня", description: "Поиск рецептов с картинками шагов приготовления по ингридиентам"}


  app.get '/title_complete_load',  (req, res) ->
    find = new RegExp(req.query.title, "i")
    Dish.find({title: find})
    .limit(15)
    .skip(req.query.skip)
    .exec (err, dishes) ->
      res.send {err: err, result: dishes}


  app.get '/title_complete',  (req, res) ->
    find = new RegExp(req.query.title, "i")
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
    filter = {}
    species = req.body.species  if req.body.species
    if species.length isnt 0
      filter.species =
        $in: species
    if req.body.kitchen and  req.body.kitchen isnt 'Любая'
      filter.kitchen = req.body.kitchen
    filter.cost = req.body.cost  if req.body.cost
    if req.body.time_cooking
      time_cooking = req.body.time_cooking.split(';')
      filter.time_cooking = {$gte: +time_cooking[0], $lte: +time_cooking[1]}
    if req.body.rating
      rating = req.body.rating.split(';')
      filter.rating = {$gte: +rating[0], $lte: +rating[1]}
    if req.body.kremling_diet
      kremling_diet = req.body.kremling_diet.split(';')
      filter.kremling_diet = {$gte: +kremling_diet[0], $lte: +kremling_diet[1]}
    if req.body.complexity
      complexity = req.body.complexity.split(';')
      filter.complexity = {$gte: +complexity[0], $lte: +complexity[1]}
    if ProductsList.length isnt 0 and ExProductsList.length isnt 0
      filter.ingredients =
        $in: ProductsList
        $nin: ExProductsList
    else unless ProductsList.length is 0
      filter.ingredients = $in: ProductsList
    else filter.ingredients = $nin: ExProductsList  unless ExProductsList.length is 0
#    dish = Dish.find filter, (err, dishes) ->
    Dish.find(filter)
    .limit(15)
    .skip(req.body.skip)
    .exec (err, dishes) ->
      if err
        console.log err
        res.send err
      result = dishes.sort((a, b) ->
        x = _.intersection(req.body.ing, a.get("ingredients")).length
        y = _.intersection(req.body.ing, b.get("ingredients")).length
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

