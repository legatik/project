_ = require('underscore')
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
    {keyKitchen, objk, objs} = app.mitching(keyKitchen, keySpecies)
    console.log "objs",objs
    rusName = objk[keyKitchen].name
    res.render 'species', {title: "tmp", user: req.user, loc:'searchIng', kitchens: objk, species:objs , key : keyKitchen}
    

  
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

