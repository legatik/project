db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'

{Dish, Product} = db.models

exports.boot = (app) ->


#Dish.find {}, (err, dishArr) ->
#  testArr = []
#  dishArr.forEach (dish) ->
#    dish.pic_equal = ""
#    if dish.id == "52a2475a2c224fbf0d000013"
#      dish.pic_equal = "1,5,6"

#    if dish.id == "52a2fdc46271deae09000005"
#      dish.pic_equal = "1,4,5"

#    if dish.id == "52a30c876271deae09000015"
#      dish.pic_equal = "2,6,8"

#    if dish.id == "52a31af56271deae0900001a"
#      dish.pic_equal = "4,5,6"

#    if dish.id == "52a320776271deae09000023"
#      dish.pic_equal = "2,3,5"

#    if dish.id == "52a3534c6271deae09000033"
#      dish.pic_equal = "1,5,6"

#    if dish.id == "52a389dd6271deae09000046"
#      dish.pic_equal = "1,2,3"

#    if dish.id == "52a4766b4802125c09000002"
#      dish.pic_equal = "1,2,3"

#    if dish.id == "52a483524802125c09000007"
#      dish.pic_equal = "1,2,4"

#    if dish.id == "52a485264802125c0900000b"
#      dish.pic_equal = "1,3,4"

#    if dish.id == "52a747eb333bb36308000004"
#      dish.pic_equal = "3,1,4"

#    if dish.id == "52a7637d333bb36308000015"
#      dish.pic_equal = "1,2,3"

#    if dish.id == "52a7670f333bb36308000017"
#      dish.pic_equal = "1,2,5"
#      
#    if dish.id == "52a324a86271deae09000025"
#      dish.pic_equal = "1,3,4"
#    dish.save()

#Product.createThis()

#Dish.find {}, (err, dishArr) ->
#  dishArr.forEach (dish) ->
#    if dish.title == "Кисель из клюквы"
#       dish.species = "Напитки"
#       dish.save()
#    if dish.title == "Сбитень"
#      dish.species = "Напитки"
#      dish.save()

#Dish.find {}, (err, dishArr) ->
#  console.log "Dish",dishArr
#  dishArr.forEach (dish) ->
#    path = "/home/legatik/worke/cook-progect/public/img/dishes/"+dish.id_picture
#    fs.readdir path, (err,st) ->
#      console.log "st",st
#      console.log "dish.id_picture",dish.id_picture
#      length = st.length
#      withoutTitle = Number(length) - 1
#      dish.qty_picture = withoutTitle
#      dish.save()


#Product.find {}, (err, products) ->
#  products.forEach (product) ->
#    if product.species == "Прочее"
##       product.save()
#       console.log "product",product
#       console.log "******"


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

