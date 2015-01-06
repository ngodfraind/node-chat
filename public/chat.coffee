window.onload = () ->
    socket     = io.connect('http://localhost:3700')
    field      = document.getElementById('field')
    sendButton = document.getElementById('send')
    content    = document.getElementById('content')

    socket.on('message', (data) ->
        html = "#{data.username}: #{data.message} </br>"
        content.innerHTML = content.innerHTML + html
    )

    sendButton.onclick = () -> 
        text = field.value
        socket.emit('send', {message: text, username: 'nico'})
