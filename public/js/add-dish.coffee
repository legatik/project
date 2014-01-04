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
          $(idImg).show()

          #для довления нового инпута
          all = ($("#im-cont-step").find(".step-inp")).length
          cheked = (Number idImg.replace("#step-img-",""))+1
          if cheked is all
            $("#im-cont-step").append(template({number:cheked}))
            addEvent()
      else
        alert("Такой фармат картинки не поддерживается")
  $("#pic-title").change ->
    readURLTitle this

  addEvent = () ->
    $(".step-inp").unbind("change")
    $(".step-inp").change ->
      id = $(@).attr("id")
      idImg = "#" + id.replace("inp","img")
      readURLStep this,idImg

  addEvent()

  $("#del-img-title").click () ->
    $("#pic-title").val("")
    $("#title-prev").attr("src","http://i.imgur.com/AeUEdJb.png")
    $("#del-img-title").hide()

