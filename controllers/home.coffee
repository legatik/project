db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Dish} = db.models

exports.boot = (app) ->

  app.post '/send_email_recept',  (req, res) ->
    attachments = []
    _.each req.files, (data,key)->
      attachments.push {filePath : data.path}


    smtpTransport = nodemailer.createTransport("SMTP",
      service: "Gmail"
      auth:
        user: "leonidova.daria@gmail.com"
        pass: "44HermionaHr44"
    )

    console.log "##########",req.body.info
    info = JSON.parse req.body.info
    console.log "info.firstName",info.firstName
    mailOptions =
      from: "legatik@list.ru"
      to: "legatik@list.ru"
      subject: "TEST ✔" # Subject line
#      text: req.body.info.toString()
      html: "<div>first name ✔ - <span>"+info.firstName+"</span></div><div>last name ✔ - <span>"+info.lastName+"</span></div></div><div>mail ✔ - <span>"+info.email+"</span></div></div><div>recept ✔ : <div>"+info.receptTxt+"</div></div>"
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

  app.get '/', (req, res) ->
    Dish.find({})
    .limit(10)
    .sort({rating: -1})
    .exec (err, dishPop) ->
      {keyKitchen, objk, objs} = app.mitching()
      res.render 'index', {title: 'Мировая кухня', user: req.user, loc:'home', kitchens: objk, species:objs, key:keyKitchen, popDish:dishPop}

  app.get '/addDish',  (req, res) ->
    {keyKitchen, objk, objs} = app.mitching()
    res.render 'add_dish', {title: 'Мировая кухня - Добавить блюдо', user: req.user, loc:'addDish', kitchens: objk, species:objs, key:keyKitchen}

