db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Dish} = db.models

exports.boot = (app) ->

  app.get '/', (req, res) ->
    console.log req.user
    Dish.find({})
    .limit(10)
    .sort({rating: -1})
    .exec (err, dishPop) ->
      {keyKitchen, objk, objs} = app.mitching()
      res.render 'index', {title: 'Мировая кухня - рецепты с картинками', user: req.user, loc:'home', kitchens: objk, species:objs, key:keyKitchen, popDish:dishPop, metaKey:"мировая кухня, зарубежная кухня, деликатесы, рецепты, кулинарные, кулинария, с картинками", description: "Все вкуснейшие рецепты мира любой сложности с картинками на одном сайте!"}

  app.post '/send_email_recept',  (req, res) ->
    attachments = []
    _.each req.files, (data,key)->
      attachments.push {filePath : data.path}


    smtpTransport = nodemailer.createTransport("SMTP",
      service: "Gmail"
      auth:
        user: "mir.cook.sup@gmail.com"
        pass: "mircooksup"
    )

    info = JSON.parse req.body.info
    console.log "info.firstName",info.firstName
    mailOptions =
      from: "mir.cook.sup@gmail.com"
      to: "mir.cook.sup@gmail.com"
      subject: "NEW RECEPT ✔" # Subject line
      html: "<div>first name ✔ - <span>"+info.firstName+"</span></div><div>last name ✔ - <span>"+info.lastName+"</span></div></div><div>mail ✔ - <span>"+info.email+"</span></div></div><div>recept ✔ : <div>"+info.receptTxt+"</div></div><div>type img ✔ - <span>"+info.typeImg+"</span></div>"
      attachments : attachments

    smtpTransport.sendMail mailOptions, (error, response) ->
      if error
        console.log error
      else
        console.log "Message sent: " + response.message
        res.send 200

  app.get '/date_dish',  (req, res) ->
    Dish.find({})
    .limit(3)
    .sort({dateAdding: -1})
    .exec (er, dishDate) ->
      res.send dishDate


  app.get '/addDish',  (req, res) ->
    {keyKitchen, objk, objs} = app.mitching()
    res.render 'add_dish', {title: 'Мировая кухня - Добавить блюдо', user: req.user, loc:'addDish', kitchens: objk, species:objs, metaKey:"кухня народов мира, добавить рецепт, блюдо, с фото", description: "Добавьте свой рецеп на сайт мировой кухни!"}

  app.get '/random_dish',  (req, res) ->
    console.log "HEARE"
    Dish.count {}, (err, count)->
      skip = Math.floor(Math.random() * count)
      console.log 'skip',skip
      Dish.find({}).skip(skip).limit(1).exec (err, dish) ->
        dish.length isnt 0 and dish=dish[0]
        id = dish._id
        {kitcchenSent,speciesSent} = app.mitching(dish.kitchen, dish.species, true, true)
        link = '/kitchen/'+kitcchenSent+'/'+speciesSent+'/'+id+"/true"
        res.redirect link

