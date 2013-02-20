$ ->
  delay = $("#intro_shell #command_input").typeline('puts "Welcome to the interactive IRB resume console."', [30..90])
  $("#intro_shell #command_input").typeline('puts "Please sign in to view Anthony\'s IRB CV."', [30..90], delay)