db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'

{Dish, Product} = db.models

exports.boot = (app) ->

#Product.createThis()






#Dish.find {}, (err, dishArr) ->
#  dishArr.forEach (dish) ->
#    path = "/home/dunice/work/project/public/img/dishes/"+dish.id_picture
#    fs.readdir path, (err,st) ->
#      console.log "st",st
#      length = st.length
#      withoutTitle = Number(length) - 1
#      dish.qty_picture = withoutTitle
##      dish.save()
      

#замена гречнеыой каши
#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.title == "гречневая каша"
#       product.species = "Крупы и орехи"
#       product.save()
#       console.log "product",product
#       console.log "****************"

#Замена Прочее
#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.species == "Прочее"
#       product.species = "Добавки и витамины"
#       product.save()
#       console.log "product",product
#       console.log "****************"
       

#Замена Крупы и каши
#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.species == "Крупы и каши"
#       product.species = "Крупы и орехи"
#       product.save()
#       console.log "product",product
#       console.log "****************"
       
#Замена Молочные продукты
#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.species == "Молочные продукты"
#       product.species = "Яйца и молочные продукты"
#       product.save()
#       console.log "product",product
#       console.log "****************"

#Замена Изюм
#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.title == "изюм"
##       product.species = "Фрукты и ягоды"
##       product.save()
#       console.log "product",product
#       console.log "*********"

#Замена Изюм
#  Product.find {}, (err, products) ->
#    products.forEach (product) ->
#      if product.title == "пшеничные сухарики"
#  #       product.species = "Мука и мучные изделия"
#  #       product.save()
#         console.log "product",product
#         console.log "*********"



##Dish.find {}, (err, products) ->
##  products.forEach (dish, index) ->
##  
##    serving = dish.serving
##    kremling = dish.kremling_diet
##    complexity = dish.complexity
##    
##    dish.kremling_diet = 1
##    dish.complexity = 1
##    dish.serving = 1
##    
##    dish.complexity = Number(complexity)
##    dish.serving = Number(serving)
##    dish.kremling_diet = Number(kremling)
##    dish.save ->
##      console.log 'index',index

