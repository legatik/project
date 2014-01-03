$(document).ready () ->
  readURLTitle = (input) ->
    if input.files and input.files[0]
      reader = new FileReader()
      reader.readAsDataURL input.files[0]
      reader.onload = (e) ->
        $("#title-prev").attr "src", e.target.result
        $("#title-prev").show()

  readURLStep = (input,idImg) ->
    template = _.template(jQuery('#stepTemplate').html())
    if input.files and input.files[0]
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

  $("#pic-title").change ->
    readURLTitle this


  $(".step-inp").change ->
    id = $(@).attr("id")
    idImg = "#" + id.replace("inp","img")
    readURLStep this,idImg

