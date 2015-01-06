window.onload = () ->
    socket     = io.connect('http://localhost:3700')
    field      = document.getElementById('field')
    sendButton = document.getElementById('send')
    messages   = document.getElementById('messages')
    users      = document.getElementById('users')

    #for now, give a random name for anyone connecting to the chatroom
    username   = 'user#' + Math.floor((Math.random() * 1000) + 1)
    socket.emit('add-user', {username: username})

    #listening sockets
    socket.on('message', (data) ->
        html = "#{data.username}: #{data.message} </br>"
        messages.innerHTML = messages.innerHTML + html
    )

    socket.on('init-user-list', (data) ->
        html = ''
        html += "#{username} </br>" for username in data.usernames
        users.innerHTML = html
    )

    socket.on('add-user', (data) ->
        html = "#{data.username} </br>"
        users.innerHTML = users.innerHTML + html
    )

    sendMessage = () ->
        text = field.value
        socket.emit('send', {message: text, username: username})

    #events
    sendButton.onclick = () ->
        sendMessage()

    document.onkeydown = (evt) ->
        if (evt.keyCode == 13 && ['name', 'field'].indexOf(document.activeElement.id) > -1 )
            sendMessage()
            
