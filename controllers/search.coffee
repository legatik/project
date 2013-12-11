db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs'

{Dish, Product} = db.models

exports.boot = (app) ->
  app.get '/title_complete',  (req, res) ->
  #	  Dish.createThis()
    console.log('HELLOOOO TIIIITTTLLLEEEE', req.query)
    find = new RegExp(req.query.title, "i")
  #	  find = '/'+req.query.title+'/'
    dish = Dish.find {title: find}, (err, dishes) ->
      dishes = dishes.map (dish) ->
        dish.title
      res.send {err: err, result: dishes}  

  app.get '/ing_autcomplete1',  (req, res) ->
    console.log "HEARE"
    Product.find {}, (err, arrProducts) ->
      console.log("err",err)
      arrTitle = arrProducts.map (product) ->
        product.title
      console.log arrTitle
      res.send {err: err, result: arrTitle}

  app.get '/ing', (req, res) ->
	  res.render 'search_ing', {title: 'Мировая кухня | Поиск по инргридиентам', user: req.user, loc:'searchIng'}

  app.get '/category', (req, res) ->
	  res.render 'search_category', {title: 'Мировая кухня | Поиск по инргридиентам', user: req.user, loc:'searchCategory'}

	  
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

