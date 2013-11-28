mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

dish = new Schema
	title : String
	who_added: {type: ObjectId, ref: 'User'}
	composition: [{ing:String,col:String}]
	recipe:Array
	species:String
	time_cooking : Number
	cost:String
	rating:Number
	status:String
	id: String
	dateAdding: Date
	comments:[{type: ObjectId, ref: 'Comment'}]
	kitchen:Number
	serving:Number
	complexity:Number
	kremling_diet:Number
	fact:String
	wish:String
	
Model = mongoose.model 'Dish', dish
module.exports = Model
