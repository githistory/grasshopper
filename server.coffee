Hapi = require 'hapi'
BB = require 'bluebird'
ck = require 'coffeekup'
ccss = require 'ccss'
coffee = require 'coffee-script'
fs = BB.promisifyAll require 'fs'
_eval = require 'eval'
Inert = require 'inert'
appRoot = process.cwd()

server = new Hapi.Server()
server.connection
  host: 'localhost'
  port: 3456

server.register Inert
server.register require './ssh'

server.route
  method: 'GET'
  path: '/'
  handler: (req, rep)->
    fs.readFileAsync "#{appRoot}/assets/index.coffee", 'utf8'
      .then (indexTemplate)-> rep ck.render indexTemplate
      .catch (err)-> rep err

server.route
  method: 'GET'
  path: '/assets/{path*}'
  handler: (req, rep)->
    path = req.params.path.split '.'
    type = path.pop()
    path = path.join '.'
    fs.readFileAsync "#{appRoot}/assets/#{path}.coffee", 'utf8'
      .then (asset)->
        switch type
          when 'html' then return rep(ck.render asset).header('Content-Type', 'text/html')
          when 'css' then return rep(ccss.compile _eval coffee.compile(asset, {bare: true})).header('Content-Type', 'text/css')
          when 'js' then return rep(coffee.compile(asset, {bare: true})).header('Content-Type', 'application/javascript')
      .catch (err)-> rep err

server.route
  method: 'GET'
  path: '/vendor/{path*}'
  handler: (req, rep)->
    rep.file "#{appRoot}/bower_components/#{req.params.path}"

server.start (err)->
  if err then throw err
  console.log "server running at #{server.info.uri}"



