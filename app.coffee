
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


app.mitchingObg =
    italy:
      name: "Итальянская"
      key: "italy"
    georgia:
      name : "Грузинская"
      key  : "georgia"
    franch : 
      name: "Французкая"
      key : "franch"
#    china :"Китайская"
#    armenia : "Армянская"
#    ukrainian : "Украинская"
#    japan : "Японская"
#    uzbek : "Узбекская"
#    indian : "Индийская"
#    azerbaijan :"Азербайджанская"
#    mexican : "Мексиканская"
#    greek : "Греческая"
#    thai : "Тайская"
#    jewish : "Еврейская"
#    turkish : "Турецкая"
#    german : "Немецкая"
#    balkan : "Балканская"
#    spanish : "Испанская"
#    korean : "Корейская"
#    moldova : "Молдавская"
#    tatar :  "Татарская"
#    belarusian : "Белорусская"
#    vietnamese : "Вьетнамская"
#    arab : "Арабская"
#    east_european : "Восточноевропейская"
#    scandinavian : "Скандинавская"
#    baltic : "Прибалтийская"
#    latin : "Латиноамериканская"
#    malaysian : "Малазийская"
#    british : "Британская"


#app.mitchingObg =
#    italy:
#      name: "Итальянская"
#      key: "italy"
#    georgia: "Грузинская"
#    franch : "Французкая"
#    china :"Китайская"
#    armenia : "Армянская"
#    ukrainian : "Украинская"
#    japan : "Японская"
#    uzbek : "Узбекская"
#    indian : "Индийская"
#    azerbaijan :"Азербайджанская"
#    mexican : "Мексиканская"
#    greek : "Греческая"
#    thai : "Тайская"
#    jewish : "Еврейская"
#    turkish : "Турецкая"
#    german : "Немецкая"
#    balkan : "Балканская"
#    spanish : "Испанская"
#    korean : "Корейская"
#    moldova : "Молдавская"
#    tatar :  "Татарская"
#    belarusian : "Белорусская"
#    vietnamese : "Вьетнамская"
#    arab : "Арабская"
#    east_european : "Восточноевропейская"
#    scandinavian : "Скандинавская"
#    baltic : "Прибалтийская"
#    latin : "Латиноамериканская"
#    malaysian : "Малазийская"
#    british : "Британская"


app.namespace '/search', require('./controllers/search').boot.bind @, app
app.namespace '/kitchen', require('./controllers/kitchen').boot.bind @, app
app.namespace '/dish', require('./controllers/dish').boot.bind @, app
app.namespace '/tool', require('./controllers/tool').boot.bind @, app


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

