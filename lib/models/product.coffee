mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

product = new Schema
  title: String
  species: String
  necessarily:Boolean
  id:String
  
Model = mongoose.model 'Product', product
module.exports = Model
