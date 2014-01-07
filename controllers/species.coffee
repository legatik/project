_ = require('underscore')
db = require '../lib/db'
exec = require('child_process').exec
{Dish} = db.models
exports.boot = (app) ->

  app.get '/speciesPage', (req, res) ->
    keySpecies = req.query.keySpecies
    keyKitchen = req.query.keyKitchen
    {keyKitchen, keySpecies} = app.mitching(keyKitchen, keySpecies, true)
    if keySpecies.name == "Первые блюда" then keySpecies.name = "Супы"
    Dish.find({$and: [{kitchen: keyKitchen.name}, {species: keySpecies.name}]}).exec (err, dish) ->
      res.send dish


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

