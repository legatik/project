mongoose = require 'mongoose'
User = require './models/user'
Product = require './models/product'
Dish = require './models/dish'

module.exports =
#	models: {user, project, team, file}
	models: {User, Product, Dish}
	connection:
		connect: (path) ->
			db = mongoose.connect path
		disconnect: () ->
		Types: mongoose.Types
