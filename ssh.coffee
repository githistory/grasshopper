SSH = require 'ssh2'
_ = require 'lodash'

exports.register = (server, options, next)->
  console.log 'registering socket io ssh server'
  io = require('socket.io') server.listener

  io.on 'connection', (socket)->
    console.log "connected #{socket.handshake.query.t}"
    socket.on 'disconnect', -> console.log "disconnected #{socket.handshake.query.t}"

    # prepare login info
    loginInfo = socket.handshake.query
    loginInfo.tryKeyboard = true
    loginInfo.port ?= '22'

    ssh = new SSH
    ssh.on 'banner', (msg, lng)->
      socket.emit 'data', msg
    ssh.on 'ready', ->
      socket.emit 'ssh-connected'
      ssh.shell
        cols: 11111111
      , (err, stream)->
        if err then return socket.emit 'status', "SSH Shell Error: #{err.message}"
        socket.on 'data', (data)-> stream.write data
        stream.on 'data', (data)-> socket.emit 'data', data.toString('utf-8')
        stream.on 'close',  -> ssh.end()
        if socket.handshake.query.command then stream.write "#{socket.handshake.query.command}\n"
    ssh.on 'end', ->
      socket.disconnect()
    ssh.on 'close', ->
      socket.disconnect()
    ssh.on 'error', (error)->
      console.log "ssh error: #{error}"
      socket.disconnect()
    ssh.on 'keyboard-interactive', (name, instructions, instructionsLang, prompts, finish)->
      finish [loginInfo.password]

    socket.on 'error', (error)->
      console.log "socket error: #{error}"
      socket.disconnect()

    socket.on 'auth', (authInfo)->
      _.assign loginInfo, JSON.parse(authInfo)
      ssh.connect loginInfo

  next()

exports.register.attributes = name: 'ssh'
