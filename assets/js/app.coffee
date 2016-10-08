angular.module 'grasshopper', ['ui.bootstrap', 'LocalStorageModule']
.value 'io', io
.value 'Terminal', Terminal
.config [
  'localStorageServiceProvider'
  (localStorageServiceProvider)->
    localStorageServiceProvider.setPrefix 'grasshopper'
]
