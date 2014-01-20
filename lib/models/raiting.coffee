mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

raiting = new Schema
	ip   : String
	st   : Boolean
	dish : {type: ObjectId, ref: 'Dish'} 
Model = mongoose.model 'Raiting', raiting

#	createThis (user, st, cb) ->
#		 @create {message:message, idUser:idUser}, (err, comment) ->


module.exports = Model
