mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

dish = new Schema
	title : String
	title_key: String
	who_added: String
	composition: [{ing:String,col:String}]
	recipe : Array
	species : String
	time_cooking : Number
	cost : String
	rating : Number
	status : String
	id_picture : String
	dateAdding : Date
	comments:[{type: ObjectId, ref: 'Comment'}]
	kitchen : String
	serving : Number
	complexity : Number
	kremling_diet : Number
	fact : String
	wish : String
	key : String
	description: String
	ingredients: Array
	
Model = mongoose.model 'Dish', dish
	
Model.createThis = () ->
  @create {title: 'Прохерованный дебил'}, () ->
    console.log('Create', arguments)


module.exports = Model
