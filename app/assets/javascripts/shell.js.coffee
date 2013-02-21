$ ->
  window.Shell =
    submitted: false
    history:
      currentIndex: 0
      commands: [""]
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
      Shell.history.currentIndex += 1

      $.ajax($("#prompt #url").val(),
             type: "POST",
             data: { code: command },
             success: (data) ->
               $("input#command_line").val("")
               $("div#log").append("<br/>irb(main)> #{command}<br/>#{data}").scrollBottom()
               Shell.history.currentIndex = Shell.history.commands.length
               Shell.submitted = false

      )

  $(document).on("keydown", (e) ->
    $("input#command_line").focus() if !e.ctrlKey
  )

  $("input#command_line").on("keydown", (e) ->
    Shell.history.up() if(e.keyCode == 38)
    Shell.history.down() if(e.keyCode == 40)
  )

  $("input#command_line").on("keyup", (e) ->
    Shell.submitCode() if(e.keyCode == 13)
    Shell.setCommand("") if(e.keyCode == 27)

  )

