mongoose = require 'mongoose'
User = require './models/user'
Product = require './models/product'
Dish = require './models/dish'
Comment = require './models/comment'

module.exports =
	models: {User, Product, Dish, Comment}
	connection:
		connect: (path) ->
			db = mongoose.connect path
		disconnect: () ->
		Types: mongoose.Types
