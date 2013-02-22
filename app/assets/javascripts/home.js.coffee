$ ->
  sentences = ['puts "Welcome to the interactive IRB resume console I built for you guys at Shopify."',
              'puts "Authentication is required since you\'ll be playing with a real irb/rails console."',
              'puts "Happy hacking!"']
  delay = 0
  for sentence in sentences
    delay = $("#intro_shell #command_input").typeline(sentence, delay: [30..90], totalDelay: delay + 150, carriageReturn: (if sentence == sentences[sentences.length - 1] then "false" else true))
