
###
 * Module dependencies.
###
express = require 'express'
http = require 'http'
path = require 'path'
mongoose = require 'mongoose'
config = require './conf/config'
require 'express-namespace'
assets = require 'connect-assets'
db = require './lib/db'
auth = require './lib/auth'
passport = require 'passport'
RedisStore = require('connect-redis')(express)
app = express()

{User,Product, Dish} = db.models

app.configure () ->
	app.set "port", process.env.PORT or 3000
	app.set "views", __dirname + "/views"
	app.set 'view engine', 'jade'
	app.use express.favicon()
	app.use express.logger 'dev'
	app.use express.bodyParser()
	app.use express.cookieParser()
	app.use express.methodOverride()
	app.use express.session
		secret: "tobeornottobethatisthequestion",
		cookie: { maxAge: 3600000 * 24 * 365, httpOnly: false }
		store: new RedisStore()
	app.use express.static path.join __dirname, 'public'
	app.use assets {src: path.join __dirname, 'public'}
	app.use passport.initialize()
	app.use passport.session()

app.configure 'development', () ->
	app.use express.errorHandler()

db.connection.connect(config.db)

auth.init app, passport

options = {db:{type: 'mongo'}}

app.namespace '/search', require('./controllers/search').boot.bind @, app
app.namespace '/kitchen', require('./controllers/kitchen').boot.bind @, app
#app.namespace '/projects', require('./controllers/projects').boot.bind @, app
#app.namespace '/files', require('./controllers/files').boot.bind @, app

#Product.createThis()

#замена гречнеыой каши
#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.title == "гречневая каша"
#       product.species = "Крупы и орехи"
##       product.save()
#       console.log "product",product
#       console.log "****************"

#Замена Прочее ? изюм
#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.species == "Прочее"
#       product.species = "Добавки и витамины"
##       product.save()
#       console.log "product",product
#       console.log "****************"
#       

#Замена Крупы и каши
#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.species == "Крупы и каши"
#       product.species = "Крупы и орехи"
##       product.save()
#       console.log "product",product
#       console.log "****************"
       
#Замена Молочные продукты
#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.species == "Молочные продукты"
#       product.species = "Яйца и молочные продукты"
##       product.save()
#       console.log "product",product
#       console.log "****************"





Dish.find {}, (err, products) ->
#  console.log "products",products
#  dish = products[products.length-1]
#  console.log "dish do",dish
#  dish.kremling_diet = dish.kremling_diet*1
#  dish.complexity = dish.complexity*1
#  dish.complexity = dish.serving*1
#  dish.save()
  products.forEach (dish, index) ->
    ser = dish.serving
    dish.kremling_diet = Number(dish.complexity)
    dish.complexity = dish.complexity*1
    dish.serving = 0
    dish.serving = Number(ser)
    console.log "dish",dish
    dish.save()
#    dish.save()
#      dish.kremling_diet = +dish.kremling_diet
#      dish.complexity = +dish.complexity
#      dish.complexity = +dish.serving
      






app.get '/', (req, res) ->
	res.render 'index', {title: 'Мировая кухня', user: req.user, loc:'home', kitchen: "all"}

app.get '/register', (req, res) ->
	res.render 'registration', {title: 'Onlile JS Compiller'}

app.post '/register', (req, res) ->
	user = req.body
	User.register user, (err,user) ->
		console.log err, user
		return res.render 'registration', {title: 'Onlile JS Compiller', err, user} if err
		res.redirect '/'

app.get '/login', (req, res) ->
	res.render 'login', {title: 'Onlile JS Compiller'}

app.post '/login', passport.authenticate("local", {failureRedirect: '/login'}), (req, res) ->
	res.redirect '/'

app.get '/logout', (req,res) ->
	req.logout()
	res.redirect '/'



http.createServer(app).listen app.get('port'), () ->
	console.log "Express server listening on port " + app.get('port')

