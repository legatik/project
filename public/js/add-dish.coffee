$(document).ready () ->
#  this.titlePic
#  this.stepArr = []
  readURLTitle = (input) =>
    if input.files and input.files[0]
      if input.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) ->
          $("#title-prev").attr "src", e.target.result
          $("#del-img-title").show()
#        this.titlePic = input.files[0]
      else
        alert("Такой фармат картинки не поддерживается")
  readURLStep = (input,idImg) =>
    template = _.template(jQuery('#stepTemplate').html())
    if input.files and input.files[0]
      if input.files[0].type == "image/png"
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) =>
          $(idImg).attr "src", e.target.result
          number = (Number idImg.replace("#step-img-",""))
          idDel = "#" + "del-step-" + number
          $(idDel).show()
#          this.stepArr.push(input.files[0])
          #для довления нового инпута
          all = ($("#im-cont-step").find(".step-inp")).length
          cheked = (Number idImg.replace("#step-img-",""))+1
          if cheked is all || all < cheked
            $("#im-cont-step").append(template({number:cheked}))
            addEvent()
      else
        alert("Такой фармат картинки не поддерживается")
  $("#pic-title").change (e) ->
    readURLTitle this

  addEvent = (e) =>
    $(".step-inp").unbind("change")
    $(".del-step").unbind("click")
    $(".step-inp").change (e) ->
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


#  $("#pic-title").change (e) =>
#    this.titlePic = e.target.files[0]
#    console.log "this.titlePic",this.titlePic

  $("#sendMail").click () =>
    sendObj = {
      firstName : $("#Fname").val()
      lastName  : $("#Lname").val()
      email     : $("#email").val()
      receptTxt : $("#recept").val()
    }
    stepArr = []
    $(".step-inp").each (index, one) ->
      if one.files.length != 0
        stepArr.push one.files[0]

    fileTitle = ($("#pic-title"))[0].files[0]


    console.log "fileTitle",fileTitle
    console.log "stepArr",stepArr
    console.log "sendObj",sendObj

    newForm = new FormData()
    newForm.append("info",JSON.stringify sendObj)
    newForm.append("fileTitle",fileTitle)
    stepArr.forEach (one, index) ->
      newForm.append("step"+index, one)

    $.ajax
      url: "/send_email_recept"
      data: newForm
      cache: false
      contentType: false
      processData: false
      type: "POST"
      success: (status) ->
        console.log "SEND"

