window.myFnShell ||= {}
window.myStaticShell ||= {}
$ ->

  myStaticShell.myShell =
    carriageReturn: (prompt, commandLine) ->
      prompt.append("<br/>irb(main):001:0> &nbsp;")
      commandLine.append("<br/>")

  myFnShell.myShell =
    typeline: (text, delayArray, totalDelay = 0) ->
      element = @
      splittedText = text.split ''
      for letter, index in text.split ''
        totalDelay += _.shuffle(delayArray)[0]
        setTimeout ->
          letter = splittedText.shift()
          console.log letter
          element.children("#line").append letter
        , totalDelay
      setTimeout($.carriageReturn, totalDelay + 50, element.siblings("#prompt"), element.children("#line"))
      totalDelay

  $.fn.extend(myFnShell.myShell)
  $.extend(myStaticShell.myShell)