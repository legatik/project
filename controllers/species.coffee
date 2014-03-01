_ = require('underscore')
db = require '../lib/db'
exec = require('child_process').exec
{Dish} = db.models
exports.boot = (app) ->

  app.get '/speciesPage', (req, res) ->
    keySpecies = req.query.keySpecies
    keyKitchen = req.query.keyKitchen
    {keyKitchen, keySpecies} = app.mitching(keyKitchen, keySpecies, true)
    if keySpecies.name == "Первые блюда" then keySpecies.name = "Супы"
    Dish.find({$and: [{kitchen: keyKitchen.name}, {species: keySpecies.name}]}).exec (err, dish) ->
      res.send dish

  app.get '/speciesDate', (req, res) ->
    keySpecies = req.query.keySpecies
    {keySpecies} = app.mitching("all", keySpecies, true)
    if keySpecies.name == "Первые блюда" then keySpecies.name = "Супы"
    Dish.find({species:keySpecies.name})
    .limit(3)
    .sort({dateAdding: -1})
    .exec (er, dishDate) ->
      res.send dishDate


  app.get '/speciesPop', (req, res) ->
    keySpecies = req.query.keySpecies
    {keySpecies} = app.mitching("all", keySpecies, true)
    if keySpecies.name == "Первые блюда" then keySpecies.name = "Супы"
    Dish.find({species:keySpecies.name})
    .limit(3)
    .sort({rating: -1})
    .exec (err, dishPop) ->
      res.send dishPop

  app.get '/speciesLoad', (req, res) ->
    keySpecies = req.query.keySpecies
    skip = req.query.skip
    sort = {}
    sort[req.query.sort] = req.query.range
    {keySpecies} = app.mitching("all", keySpecies, true)
    if keySpecies.name == "Первые блюда" then keySpecies.name = "Супы"
    Dish.find({species:keySpecies.name})
    .limit(10)
    .sort(sort)
    .skip(skip)
    .exec (err, dish) ->
      res.send dish

  app.get '/type/:species', (req, res) ->
    keySpecies = req.params.species
    {keyKitchen, objk, objs} = app.mitching(keyKitchen, null)
    rusName = objs[keySpecies].name
    res.render 'species', {title: "Мировая кухня - " + rusName, user: req.user, loc:'searchIng', kitchens: objk, species:objs , key : keyKitchen, keySpecies : keySpecies, description: "" +rusName+". Вкуснейшие блюда! Рецепты любой сложности с картинками пошагового приготовления", metaKey: rusName+ ", кулинарные, приготовить, с фото, картинками"}

