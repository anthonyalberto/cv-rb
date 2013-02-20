window.Shell ||= {}
$ ->

  Shell.submitCode = ->
    $.ajax($("#prompt #url").val(),
           type: "POST",
           data: { code: $("input#code").val() },
           success: (data) ->
             $("div#log").html(data)
    )


  $("input#code").on("keyup", (e) ->
    Shell.submitCode() if(e.keyCode == 13)
  )
