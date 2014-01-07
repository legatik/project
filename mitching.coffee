_ = require 'underscore'
module.exports  = (keyKitchen,keySpecies, jastName) ->
  specObj =
    first_course:
      name : "Первые блюда"
      key : "first_course"
    main_dishes:
      name : "Вторые блюда"
      key : "main_dishes"
    snack:
      name : "Закуски"
      key : "snack"
    salad:
      name : "Салаты"
      key : "salad"
    dessert:
      name : "Десерты"
      key : "dessert"
    bake:
      name : "Выпечка"
      key : "bake"
    drinks:
      name : "Напитки"
      key : "drinks"


  kitchenObj =
      russian:
        name: "Русская"
        key: "russian"
      italy:
        name: "Итальянская"
        key: "italy"
      georgia:
        name : "Грузинская"
        key  : "georgia"
      franch :
        name: "Французкая"
        key : "franch"
  #    china :"Китайская"
  #    armenia : "Армянская"
  #    ukrainian : "Украинская"
  #    japan : "Японская"
  #    uzbek : "Узбекская"
  #    indian : "Индийская"
  #    azerbaijan :"Азербайджанская"
  #    mexican : "Мексиканская"
  #    greek : "Греческая"
  #    thai : "Тайская"
  #    jewish : "Еврейская"
  #    turkish : "Турецкая"
  #    german : "Немецкая"
  #    balkan : "Балканская"
  #    spanish : "Испанская"
  #    korean : "Корейская"
  #    moldova : "Молдавская"
  #    tatar :  "Татарская"
  #    belarusian : "Белорусская"
  #    vietnamese : "Вьетнамская"
  #    arab : "Арабская"
  #    east_european : "Восточноевропейская"
  #    scandinavian : "Скандинавская"
  #    baltic : "Прибалтийская"
  #    latin : "Латиноамериканская"
  #    malaysian : "Малазийская"
  #    british : "Британская"




  #kitchen
  obk = _.clone(kitchenObj)
  objkStr = JSON.stringify(obk)
  objk = JSON.parse(objkStr)


  #species
  obs = _.clone(specObj)
  objsStr = JSON.stringify(obs)
  objs = JSON.parse(objsStr)

#  if keyKitchen && keySpecies
#    objk[keyKitchen].class = "active"
#    objs[keySpecies].class = "active"
#    return {keyKitchen, objk, objs}

  if jastName
    keyKitchen = kitchenObj[keyKitchen]
    keySpecies = specObj[keySpecies]
    return {keyKitchen, keySpecies}


  if keyKitchen && keyKitchen !="all" && !keySpecies
    objk[keyKitchen].class = "active"
    return {keyKitchen, objk, objs}

  if keyKitchen && keySpecies
    objs[keySpecies].class = "active"
    return {keyKitchen, objk, objs}

  keyKitchen="all"
  return {keyKitchen, objk, objs}

