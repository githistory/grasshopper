angular.module 'grasshopper'
.controller 'login', [
  '$scope', 'loginInfo'
  ($scope, loginInfo)->
    $scope.updateLoginInfo = ->
      $scope.$close $scope.loginInfo

    $scope.loginInfo = angular.copy loginInfo
]


