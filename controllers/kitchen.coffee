_ = require('underscore')
exports.boot = (app) ->





  app.get '/:kitchen', (req, res) ->
    key = req.params.kitchen
    
    ob = _.clone(app.mitchingObg)
    objStr = JSON.stringify(ob)
    obj = JSON.parse(objStr)
        
    rusName = obj[key].name
    obj[key].class = "active"
    
    title = "Мировая кухня | " + rusName + " кухня" 
    res.render 'kitchen', {title: title, user: req.user, loc:'searchIng', kitchens: obj, temp: rusName + " кухня", key : key}



  app.get '/:kitchen/:species', (req, res) ->
    keyKitchen = req.params.kitchen
    keySpecies = req.params.species
    ob = _.clone(app.mitchingObg)
    objStr = JSON.stringify(ob)
    obj = JSON.parse(objStr)
    obj[keyKitchen].class = "active"
    rusName = obj[keyKitchen].name
    
    res.render 'species', {title: "tmp", user: req.user, loc:'searchIng', kitchens: obj, key : keyKitchen}
    

  
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

