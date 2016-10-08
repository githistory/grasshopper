doctype 5
html 'ng-app':'grasshopper', ->
  head ->
    meta charset:'utf-8'
    title "Grasshopper | A web ssh client"

    link rel:'stylesheet', href:'/vendor/bootstrap/dist/css/bootstrap.css'
    link rel:'stylesheet', href:'/vendor/angular-bootstrap/ui-bootstrap-csp.css'
    link rel:'stylesheet', href:'/vendor/bootswatch/paper/bootstrap.css'
    link rel:'stylesheet', href:'/vendor/xterm.js/dist/xterm.css'
    link rel:'stylesheet', href:'/assets/css/app.css'

    script src:'/vendor/angular/angular.js'
    script src:'/vendor/angular-bootstrap/ui-bootstrap-tpls.js'
    script src:'/vendor/socket.io-client/socket.io.js'
    script src:'/vendor/angular-local-storage/dist/angular-local-storage.js'
    script src:'/vendor/xterm.js/dist/xterm.js'
    script src:'/vendor/xterm.js/addons/fit/fit.js'
    script src:'/assets/js/app.js'
    script src:'/assets/js/controllers/app.js'
    script src:'/assets/js/controllers/login.js'
    script src:'/assets/js/services/ssh.js'
    script src:'/assets/js/services/terminal.js'

  body 'ng-controller':'app', ->
    div '#terminal-container', ->
    div '#footer', ->
      span '#login-info', 'ng-click':'promptForLoginInfo()', 'ng-class':"{'connected': connected}", -> '{{loginInfo.username}}@{{loginInfo.host}}'

