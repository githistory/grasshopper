doctype 5
html ->
  head ->
    meta charset: 'utf-8'
    title "#{@title or 'Untitled'} | A completely plausible website"
    meta(name: 'description', content: @description) if @description?

    link rel: 'stylesheet', href: '/css/app.css'

    style '''
      body {font-family: sans-serif}
      header, nav, section, footer {display: block}
    '''

    script src: '/vendor/angular/angular.js'

    coffeescript ->
      alert 'Coffee Stack!'

  body ->
    header ->
      h1 @title or 'Untitled'

      nav ->
        ul ->
          (li -> a href: '/', -> 'Home') unless @path is '/'
          li -> a href: '/chunky', -> 'Bacon!'

    section ->

      h2 "Let's count to 10:"

      p i for i in [1..10]

    footer ->
      # CoffeeScript comments. Not visible in the output document.
      comment 'HTML comments.'
      p 'Bye!'
