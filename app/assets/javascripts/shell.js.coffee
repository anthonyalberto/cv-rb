$ ->

  window.Konami =
    konamiBuffer: []
    konamiSequence: '38,38,40,40,37,39,37,39,66,65'
    detectKonami: (e) ->
      Konami.konamiBuffer.push(e.keyCode)
      Konami.konamiBuffer = Konami.konamiBuffer[-10..-1]
      Konami.triggerMenu() if Konami.konamiBuffer.toString() == Konami.konamiSequence

    triggerMenu: ->
      try
        if /webkit|msie/i.test(navigator.userAgent)
          new Audio("/sounds/pacman.mp3").play()
        else
          new Audio("/sounds/pacman.wav").play()
      catch err
        #Safari 5 on Windows fail
      Shell.setCommand("")
      $("#cheat_menu").fadeIn(3000)
  #End window.Konami


  window.Shell =
    submitted: false

    history:
      currentIndex: 0
      commands: [""]
      replayCommands: []
      up: ->
        Shell.history.currentIndex -=  1 if Shell.history.currentIndex > 0
        Shell.setCommand(Shell.history.commands[Shell.history.currentIndex])

      down: ->
        Shell.history.currentIndex +=  1 if Shell.history.currentIndex < Shell.history.commands.length - 1
        Shell.setCommand(Shell.history.commands[Shell.history.currentIndex])

    setCommand: (value) ->
      $("input#command_line").val(value)

    currentCommand: ->
      $("input#command_line").val()

    firePopup: (data) ->
      $('#popup').html(data)
      $('.modal').modal('show', keyboard: true)

    submitCode: ->
      return if Shell.submitted || Shell.currentCommand() == ""
      Shell.submitted = true
      command = Shell.currentCommand()
      Shell.history.commands.push(command)

      fullCommand = Shell.history.replayCommands.join(";") + ";#{command}"
      Shell.history.currentIndex += 1

      $.ajax $("#prompt #url").val(),
             type: "POST"
             dataType: 'json'
             data: { code: fullCommand }
             timeout: 3000
             success: (jsonData) ->
               $("input#command_line").val("")
               $("div#log").append("<br/>irb(main)> #{command}<br/>").scrollBottom()
               if /decorator_modal/.test(jsonData.html)
                 Shell.firePopup(jsonData.html)
               else
                 $("div#log").append(jsonData.html).scrollBottom()
               Shell.history.replayCommands.push command if jsonData.status == "assignment"
               Shell.history.currentIndex = Shell.history.commands.length
             error: (e) ->
               $("div#log").append("<br/>irb(main)> #{command}<br/><div class='console_error'>#{I18n.t("shell.instructions.error")}</div>").scrollBottom()
             complete: ->
               $("input#command_line").val("")
               Shell.submitted = false
  #End window.Shell

  $(document).on "keydown", (e) ->
    $("input#command_line").focus() if !e.ctrlKey

  $(document).on "keydown", Konami.detectKonami

  $("input#command_line").on "keydown", (e) ->
    if(e.keyCode == 38)
      e.preventDefault()
      Shell.history.up()
    Shell.history.down() if(e.keyCode == 40)


  $("input#command_line").on "keyup", (e) ->
    Shell.submitCode() if(e.keyCode == 13)
    Shell.setCommand("") if(e.keyCode == 27)

  $("#reset_shell").on "click", (e) ->
    location.reload() if confirm(I18n.t("shell.index.reset_confirmation"))

  $(".cheat_link").on "click", ->
    action = $(@).data("cheat");
    Shell.setCommand("Candidate.where(name: 'Anthony Alberto').first.decorate.#{action}")
    Shell.submitCode()

  $("#toggle").on "click", ->
    div = $(".explanations_container")
    if div.is(':visible') then div.slideUp('slow') else div.slideDown('slow')
