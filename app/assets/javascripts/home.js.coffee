$ ->
  delay = $("#intro_shell #command_input").typeline('puts "Welcome to the interactive IRB resume console I built for yous guys at Shopify."', delay: [30..90])
  delay = $("#intro_shell #command_input").typeline('puts "Authentication is required since you\'ll be playing with a real irb/rails console."', delay: [30..90], totalDelay: delay + 150)
  delay = $("#intro_shell #command_input").typeline('puts "Happy hacking!"', delay: [30..90], totalDelay: delay + 150, carriageReturn: "false")