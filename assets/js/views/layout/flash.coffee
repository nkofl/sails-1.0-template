flash = 
  error: (message, delay) ->
    flash.add message, delay, 'danger'

  update: (message, delay) ->
    flash.add message, delay, 'success'

  add: (message, delay, msgType) ->
    newMsg = $ "<div/>", 
      "class": "alert alert-#{msgType} fade show"
      text: message
      "id": "flashMessage"
    newMsg.appendTo "#flashMessages"
    setTimeout () ->
      newMsg.alert 'close'
    , delay

this.flash = flash