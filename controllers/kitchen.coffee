
exports.boot = (app) ->

  app.get '/:kitchen', (req, res) ->
    console.log "heare@@!!!",req.params.kitchen
#    res.render 'kitchen', {title: 'Мировая кухня | Итальянская кухня', user: req.user, loc:'searchIng', kitchen:"Итальянская"}

	  
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

