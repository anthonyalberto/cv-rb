window.myFnShell ||= {}
window.myStaticShell ||= {}
$ ->

  myStaticShell.myShell =
    carriageReturn: (prompt, commandLine) ->
      commandLine.append("<br/>")

  myFnShell.myShell =
    scrollBottom: ->
      @.scrollTop(@[0].scrollHeight)

    appendScrollBottom: (html) ->
      @.append(html)
      @.scrollBottom

    typeline: (text, options = {}) ->
      options['delay'] ||= [30..90]
      options['totalDelay'] ||= 0
      options['carriageReturn'] ||= true
      element = @
      setTimeout(->
        element.children("#line").append "irb(main)> &nbsp;"
      , options['totalDelay'])
      splittedText = text.split ''
      for letter, index in text.split ''
        options['totalDelay'] += _.shuffle(options['delay'])[0]
        setTimeout ->
          letter = splittedText.shift()
          element.children("#line").append letter
        , options['totalDelay']
      setTimeout($.carriageReturn, options['totalDelay'] + 50, element.siblings("#prompt"), element.children("#line")) if options['carriageReturn'] != "false"
      options['totalDelay']

  $.fn.extend(myFnShell.myShell)
  $.extend(myStaticShell.myShell)