mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

comment = new Schema
  idUser: ObjectId
  message: String
  
Model = mongoose.model 'Comment', comment

Model.createThis = () ->
  @create {message:"test"}, () ->
    console.log "create"

module.exports = Model
