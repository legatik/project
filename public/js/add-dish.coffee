$(document).ready () ->
  readURLTitle = (input) ->
    if input.files and input.files[0]
      if input.files[0].type == "image/png"
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) ->
          $("#title-prev").attr "src", e.target.result
          $("#del-img-title").show()
      else
        alert("Такой фармат картинки не поддерживается")
  readURLStep = (input,idImg) ->
    template = _.template(jQuery('#stepTemplate').html())
    if input.files and input.files[0]
      if input.files[0].type == "image/png"
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) ->
          $(idImg).attr "src", e.target.result
          number = (Number idImg.replace("#step-img-",""))
          idDel = "#" + "del-step-" + number
          console.log "idDel",idDel
          console.log "idDel2",$(idDel)
          $(idDel).show()
          #для довления нового инпута
          all = ($("#im-cont-step").find(".step-inp")).length
          cheked = (Number idImg.replace("#step-img-",""))+1
          console.log "all",all
          console.log "cheked",cheked
          if cheked is all || all < cheked
            $("#im-cont-step").append(template({number:cheked}))
            addEvent()
      else
        alert("Такой фармат картинки не поддерживается")
  $("#pic-title").change ->
    readURLTitle this

  addEvent = () ->
    $(".step-inp").unbind("change")
    $(".del-step").unbind("click")
    $(".step-inp").change ->
      id = $(@).attr("id")
      idImg = "#" + id.replace("inp","img")
      readURLStep this,idImg

    $(".del-step").click () ->
      $($(@).parent()).remove()

  addEvent()

  $("#del-img-title").click () ->
    $("#pic-title").val("")
    $("#title-prev").attr("src","http://i.imgur.com/AeUEdJb.png")
    $("#del-img-title").hide()

