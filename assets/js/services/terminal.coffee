angular.module 'grasshopper'
.service 'terminal', [
  '$document', 'Terminal'
  ($document, Terminal)->
    svc = {}
    term = null

    svc.init = (callbacks, domId='terminal-container')->
      unless callbacks.data then throw new Error 'missing callbacks'
      term = new Terminal
        cursorBlink: true
        visualBell: true
        popOnBell: true
        scrollback: 10000
      term.on 'data', callbacks.data
      term.open document.getElementById domId
      term.fit()
      svc

    svc.write = (data)-> term.write data
    svc.fit = -> term.fit()
    svc.clear = -> term.clear()

    svc
]



