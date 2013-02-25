window.myFnShell ||= {}
$ ->

  myFnShell.myShell =
    scrollBottom: ->
      @.scrollTop(@[0].scrollHeight)

    typeline: (text, options = {}) ->
      options['delay'] ||= [30..90]
      options['totalDelay'] ||= 0
      options['carriageReturn'] ||= true
      element = @
      setTimeout(->
        element.children("#line").append "irb(main)> &nbsp;"
      , options['totalDelay'])
      splittedText = text.split ''
      for letter in text.split ''
        options['totalDelay'] += _.shuffle(options['delay'])[0]
        setTimeout ->
          letter = splittedText.shift()
          element.children("#line").append letter
        , options['totalDelay']
      if options['carriageReturn'] != "false"
        setTimeout(->
          element.children("#line").append("<br/>")
        , options['totalDelay'] + 50)
      options['totalDelay']
  #End myFnShell.mySHell

  $.fn.extend(myFnShell.myShell)