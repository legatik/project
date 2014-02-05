mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

raiting = new Schema
	st   : Boolean
	dish : {type: ObjectId, ref: 'Dish'} 
Model = mongoose.model 'Raiting', raiting

Model.createThis = (st,  dishId) ->
  @create {st:st, dish:dishId}, (err, raiting) ->
    console.log "err",err
    console.log "raiting",raiting


module.exports = Model
