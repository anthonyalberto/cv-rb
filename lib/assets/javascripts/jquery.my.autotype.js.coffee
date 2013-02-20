$ ->
  $.fn.autotype = (text, delayArray) ->
    element = this
    totalDelay = 0
    splittedText = text.split ''
    for letter, index in text.split ''
      totalDelay += _.shuffle(delayArray)[0]
      console.log totalDelay
      setTimeout ->
        letter = splittedText.shift()
        console.log letter
        element.append letter
      , totalDelay