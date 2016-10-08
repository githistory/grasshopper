borderRadius = (str) ->
  WebkitBorderRadius: str
  MozBorderRadius:    str
  borderRadius:       str

boxShadow = (str) ->
  WebkitBoxShadow: str
  MozBoxShadow:    str
  boxShadow:       str


module.exports =
  body:
    backgroundColor: 'rgb(0, 0, 0)'
    margin: 0
    fontSize: '15px'

  '#terminal-container':
    position: 'fixed'
    top: 0
    right: 0
    bottom: '28px'
    left: 0
    overflow: 'hidden'
    fontSize: '11px'
    lineHeight: '12px'

  '#footer':
    position: 'fixed'
    bottom: 0
    left: 0
    right: 0
    backgroundColor: 'rgb(50, 50, 50)'
    borderColor: 'white'
    borderStyle: 'solid none none none'
    borderWidth: '1px'
    zIndex: '99'

  '#login-info':
    display: 'inline-block'
    color: 'rgb(240, 240, 240)'
    backgroundColor: 'red'
    padding: '0 10px'
    cursor: 'pointer'
  '#login-info.connected':
    backgroundColor: 'green'


