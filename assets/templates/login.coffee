div '.modal-header', ->
  h3 '.modal-title', -> 'Login Information'
div '.modal-body', ->
  form ->
    div '.form-group', ->
      input '.form-control', type:'text', placeholder:'Host', 'ng-model':'loginInfo.host'
    div '.form-group', ->
      input '.form-control', type:'text', placeholder:'Port ( Default: 22 )', 'ng-model':'loginInfo.port'
    div '.form-group', ->
      input '.form-control', type:'text', placeholder:'Username', 'ng-model':'loginInfo.username'
    div '.form-group', 'ng-hide':'loginInfo.usePrivateKey', ->
      input '.form-control', type:'password', placeholder:'Password', 'ng-model':'loginInfo.password'
    div '.form-group', 'ng-show':'loginInfo.usePrivateKey', ->
      textarea '.form-control', placeholder:'Private Key', 'ng-model':'loginInfo.privateKey'
    div '.checkbox', ->
      label ->
        input type:'checkbox', 'ng-model':'loginInfo.usePrivateKey'
        'Use Private Key'
div '.modal-footer', ->
  button '.btn.btn-primary', 'ng-click':'updateLoginInfo()', -> 'Connect'
  button '.btn.btn-default', 'ng-click':'$dismiss()', -> 'Cancel'


