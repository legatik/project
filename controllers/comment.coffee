db = require '../lib/db'

{Comment} = db.models

exports.boot = (app) ->
  app.post 'create', (req, res) ->
    idUser = req.body.userId
    idDish = req.body.dishId
    message = req.body.message
    Comment.createThis idUser, idDish, message, (err)->
      if err 
        res.send err
      else
        res.send 200
        
  app.get 'find', (req, res) ->
    idComment = req.query.idComment
    Comment.find({_id: {$in: idComment}}).populate("idUser").exec (err, comments) ->
      res.send comments  

