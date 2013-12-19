
exports.boot = (app) ->

  mitchingObg =
    italy:"Итальянская"
    georgia: "Грузинская"
    franch : "Французкая"
    china :"Китайская"
    armenia : "Армянская"
    ukrainian : "Украинская"
    japan : "Японская"
    uzbek : "Узбекская"
    indian : "Индийская"
    azerbaijan :"Азербайджанская"
    mexican : "Мексиканская"
    greek : "Греческая"
    thai : "Тайская"
    jewish : "Еврейская"
    turkish : "Турецкая"
    german : "Немецкая"
    balkan : "Балканская"
    spanish : "Испанская"
    korean : "Корейская"
    moldova : "Молдавская"
    tatar :  "Татарская"
    belarusian : "Белорусская"
    vietnamese : "Вьетнамская"
    arab : "Арабская"
    east_european : "Восточноевропейская"
    scandinavian : "Скандинавская"
    baltic : "Прибалтийская"
    latin : "Латиноамериканская"
    malaysian : "Малазийская"
    british : "Британская"

  app.get '/:kitchen', (req, res) ->
    key = req.params.kitchen
    rusName = mitchingObg[key]
    title = "Мировая кухня | " + rusName + " кухня" 
    res.render 'kitchen', {title: title, user: req.user, loc:'searchIng', kitchen: key, temp: rusName + " кухня"}

	  
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

