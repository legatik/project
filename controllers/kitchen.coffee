_ = require('underscore')
db = require '../lib/db'
exec = require('child_process').exec
{Dish} = db.models
exports.boot = (app) ->

  app.get '/:kitchen', (req, res) ->
    #kitchen
    keyKitchen = req.params.kitchen
    {keyKitchen, objk, objs} = app.mitching(keyKitchen)
    rusName = objk[keyKitchen].name
    title = "Мировая кухня | " + rusName + " кухня"
    res.render 'kitchen', {title: title, user: req.user, loc:'searchIng', kitchens: objk, temp: rusName + " кухня", key : keyKitchen, species:objs}

  app.get '/:kitchen/:species', (req, res) ->
    keyKitchen = req.params.kitchen
    keySpecies = req.params.species
    console.log "keyKitchen",keyKitchen
    {keyKitchen, objk, objs} = app.mitching(keyKitchen, keySpecies)
    res.render 'species', {title: "tmp", user: req.user, loc:'searchIng', kitchens: objk, species:objs , key : keyKitchen, keySpecies : keySpecies}

  app.get '/:kitchen/:species/:dish', (req, res) ->
    idDish = req.params.dish
    Dish.findOne {_id: idDish}, (err, dish) ->
      if err
        console.log "tipo 404 (nuzno sdelat stranicy)"
        res.send 404
      else
        keyKitchen = req.params.kitchen
        keySpecies = req.params.species
        {keyKitchen, objk, objs} = app.mitching(keyKitchen, keySpecies)
        title = "Мировая кухня | "+ dish.title_key
        res.render 'dish-page', {title: title, user: req.user, kitchens: objk, species:objs , key : keyKitchen, dish:dish}


# Comment.find({_id: {$in: idComment}}).populate("idUser").exec (err, comments) ->


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

