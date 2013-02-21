$ ->
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
    submitCode: ->
      return if Shell.submitted || Shell.currentCommand() == ""
      Shell.submitted = true
      command = Shell.currentCommand()
      Shell.history.commands.push(command)

      fullCommand = Shell.history.replayCommands.join(";") + ";#{command}"
      console.log fullCommand
      Shell.history.currentIndex += 1

      $.ajax($("#prompt #url").val(),
             type: "POST",
             dataType: 'json',
             data: { code: fullCommand },
             timeout: 3000,
             success: (jsonData) ->
               $("input#command_line").val("")
               $("div#log").append("<br/>irb(main)> #{command}<br/>#{jsonData.html}").scrollBottom()
               Shell.history.replayCommands.push command if jsonData.status == "assignment"
               Shell.history.currentIndex = Shell.history.commands.length
             , error: (e) ->
               $("div#log").append("<br/>irb(main)> #{command}<br/><div class='console_error'>Wooow something bad happened, what did you try??</div>").scrollBottom()
             , complete: ->
               $("input#command_line").val("")
               Shell.submitted = false
      )

  $(document).on("keydown", (e) ->
    $("input#command_line").focus() if !e.ctrlKey
  )

  $("input#command_line").on("keydown", (e) ->
    if(e.keyCode == 38)
      e.preventDefault()
      Shell.history.up()
    Shell.history.down() if(e.keyCode == 40)
  )

  $("input#command_line").on("keyup", (e) ->
    Shell.submitCode() if(e.keyCode == 13)
    Shell.setCommand("") if(e.keyCode == 27)

  )

