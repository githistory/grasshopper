angular.module 'grasshopper'
.controller 'app', [
  '$scope', '$uibModal', '$log', '$window', '$timeout', 'localStorageService', 'ssh', 'terminal'
  ($scope, $uibModal, $log, $window, $timeout, localStorageService, ssh, terminal)->
    # functions
    $scope.openLoginModal = (loginInfo)->
      $uibModal.open
        templateUrl: '/assets/templates/login.html'
        controller: 'login'
        resolve:
          loginInfo: loginInfo

    $scope.promptForLoginInfo = ->
      $scope.openLoginModal($scope.loginInfo).result
        .then (loginInfo)->
          $scope.loginInfo = loginInfo
          $scope.checkAndConnect()
        .catch (err)->
          console.log err
          $log.info 'login canceled'

    $scope.connect = ->
      ssh.connect $scope.loginInfo,
        connect: ->
          terminal.clear()
          $timeout -> $scope.connected = true
        disconnect: -> $timeout -> $scope.connected = false
        error: -> $timeout -> $scope.connected = false
        data: (data)-> terminal.write data

    $scope.checkAndConnect = ->
      unless $scope.loginInfo.host and $scope.loginInfo.username and ($scope.loginInfo.password or $scope.loginInfo.privateKey) then return false
      $scope.connect()
      true

    $scope.getQueryParameters = ->
      search = $window.location.search.substring 1
      unless search then return {}
      JSON.parse '{"' + search.replace(/&/g, '","').replace(/=/g,'":"') + '"}', (key, value)->
        return if key=="" then value else decodeURIComponent(value)

    # watches
    $scope.$watch 'loginInfo', (nv)->
      unless nv then return
      localStorageService.set 'loginInfo', angular.toJson($scope.loginInfo)
    , true

    angular.element($window).bind 'resize', terminal.fit

    # init
    terminal.init
      data: (data)-> ssh.write data

    try
      $scope.loginInfo = angular.extend {}, angular.fromJson(localStorageService.get('loginInfo')), $scope.getQueryParameters()
    catch err
      $scope.loginInfo = {}

    unless $scope.checkAndConnect() then $scope.promptForLoginInfo()

]

