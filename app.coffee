
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

{User,Product, Dish, Comment, Raiting} = db.models


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

#app.mitchingObg =
#    italy: "Итальянская"
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

app.mitching = require './mitching'

app.namespace '', require('./controllers/home').boot.bind @, app
app.namespace '/search', require('./controllers/search').boot.bind @, app
app.namespace '/kitchen', require('./controllers/kitchen').boot.bind @, app
app.namespace '/comment', require('./controllers/comment').boot.bind @, app
app.namespace '/species', require('./controllers/species').boot.bind @, app
app.namespace '/tool', require('./controllers/tool').boot.bind @, app
app.namespace '/kitchenGet', require('./controllers/kitchenGet').boot.bind @, app


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

#Comment.createThis()

#smtpTransport = nodemailer.createTransport("SMTP",
#  service: "Gmail"
#  auth:
#    user: "leonidova.daria@gmail.com"
#    pass: "44HermionaHr44"
#)
#attachments = [
#  filePath: "121.jpg"
#]

#mailOptions =
#  from: "legatik@list.ru"
#  to: "legatik@list.ru"
#  subject: "Hello ✔" # Subject line
#  text: "Hello world ✔" # plaintext body
#  html: "<b>Hello world ✔</b>" # html body
#  attachments : attachments

#smtpTransport.sendMail mailOptions, (error, response) ->
#  if error
#    console.log error
#  else
#    console.log "Message sent: " + response.message


http.createServer(app).listen app.get('port'), () ->
	console.log "Express server listening on port " + app.get('port')

