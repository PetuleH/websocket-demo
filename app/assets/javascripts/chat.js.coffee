$ ->
  socket = new WebSocket "ws://#{window.location.host}/chat"

  socket.onmessage = (event) ->
    #if event.data.length
      #console.log(event)
      #$("#output").append "#{event.data}<br>"

  $("body").on "submit", "form.chat", (event) ->
    event.preventDefault()    
    socket.send JSON.stringify({message: $("#msg").val(), user: $("#user").val()})
    $("#msg").val("")
