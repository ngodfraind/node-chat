express = require('express')

app = express()
port = 3700
usernames = []

app.set('views', __dirname + '/views')
app.set('view engine', 'jade')
app.engine('jade', require('jade').__express)
app.use(express.static(__dirname + '/public'))

#routing
app.get('/', (req, res) ->
    res.render('page')
)

io = require('socket.io').listen(app.listen(port))

io.sockets.on('connection', (socket) ->
    socket.emit('message', { message: 'welcome to the chat', username: 'Server'})
    socket.emit('init-user-list', {usernames: usernames})

    socket.on('send', (data) ->
        io.sockets.emit('message', data)
    )

    socket.on('add-user', (data) ->
        usernames.push(data.username)
        io.sockets.emit('add-user', data)
    )
)

console.log("Listening on port #{port}")
