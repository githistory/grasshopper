angular.module 'grasshopper'
.service 'ssh', [
  'io'
  (io)->
    svc = {}
    socket = null

    svc.connect = (loginInfo, callbacks)->
      unless callbacks.connect and callbacks.data and callbacks.disconnect and callbacks.error then throw new Error 'missing callbacks'

      if socket
        socket.io.reconnection false
        socket.disconnect()

      socket = io.connect '/',
        query: "host=#{loginInfo.host}\
                &port=#{loginInfo.port or '22'}\
                &username=#{loginInfo.username}\
                #{if loginInfo.command then "&command=#{loginInfo.command}" else ''}"
        secure: true

      socket.on 'connect', ->
        authInfo = if loginInfo.usePrivateKey then privateKey: loginInfo.privateKey else password: loginInfo.password
        socket.emit 'auth', angular.toJson(authInfo)
      socket.on 'ssh-connected', callbacks.connect
      socket.on 'disconnect', ->
        socket.io.reconnection false
        callbacks.disconnect()
      socket.on 'error', callbacks.error
      socket.on 'data', callbacks.data

    svc.write = (data)->
      unless socket then return
      socket.emit 'data', data


    svc
]


